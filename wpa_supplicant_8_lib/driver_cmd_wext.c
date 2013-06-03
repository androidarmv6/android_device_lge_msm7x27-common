/*
 * Driver interaction with extended Linux Wireless Extensions
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Alternatively, this software may be distributed under the terms of BSD
 * license.
 *
 */

#include "includes.h"
#include <sys/ioctl.h>
#include <net/if_arp.h>
#include <net/if.h>

#include "linux_wext.h"
#include "common.h"
#include "driver.h"
#include "eloop.h"
#include "priv_netlink.h"
#include "driver_wext.h"
#include "ieee802_11_defs.h"
#include "wpa_common.h"
#include "wpa_ctrl.h"
#include "wpa_supplicant_i.h"
#include "config.h"
#include "linux_ioctl.h"
#include "scan.h"

#include "driver_cmd_wext.h"
#ifdef ANDROID
#include "android_drv.h"
#endif /* ANDROID */


static char *wpa_driver_get_country_code(int channels)
{
	char *country = "US"; /* WEXT_NUMBER_SCAN_CHANNELS_FCC */

	if (channels == WEXT_NUMBER_SCAN_CHANNELS_ETSI)
		country = "EU";
	else if( channels == WEXT_NUMBER_SCAN_CHANNELS_MKK1)
		country = "JP";
	return country;
}

static int wpa_driver_set_backgroundscan_params(void *priv)
{
	struct wpa_driver_wext_data *drv = priv;
	struct wpa_supplicant *wpa_s;
	struct iwreq iwr;
	int ret = 0, i = 0, bp;
	char buf[WEXT_PNO_MAX_COMMAND_SIZE];
	struct wpa_ssid *ssid_conf;

	if (drv == NULL) {
		wpa_printf(MSG_ERROR, "%s: drv is NULL. Exiting", __func__);
		return -1;
	}
	if (drv->ctx == NULL) {
		wpa_printf(MSG_ERROR, "%s: drv->ctx is NULL. Exiting", __func__);
		return -1;
	}
	wpa_s = (struct wpa_supplicant *)(drv->ctx);
	if (wpa_s->conf == NULL) {
		wpa_printf(MSG_ERROR, "%s: wpa_s->conf is NULL. Exiting", __func__);
		return -1;
	}
	ssid_conf = wpa_s->conf->ssid;

	bp = WEXT_PNOSETUP_HEADER_SIZE;
	os_memcpy(buf, WEXT_PNOSETUP_HEADER, bp);
	buf[bp++] = WEXT_PNO_TLV_PREFIX;
	buf[bp++] = WEXT_PNO_TLV_VERSION;
	buf[bp++] = WEXT_PNO_TLV_SUBVERSION;
	buf[bp++] = WEXT_PNO_TLV_RESERVED;

	while ((i < WEXT_PNO_AMOUNT) && (ssid_conf != NULL)) {
		/* Check that there is enough space needed for 1 more SSID, the other sections and null termination */
		if ((bp + WEXT_PNO_SSID_HEADER_SIZE + IW_ESSID_MAX_SIZE + WEXT_PNO_NONSSID_SECTIONS_SIZE + 1) >= (int)sizeof(buf))
			break;
		if ((!ssid_conf->disabled) && (ssid_conf->ssid_len <= IW_ESSID_MAX_SIZE)){
			wpa_printf(MSG_DEBUG, "For PNO Scan: %s", ssid_conf->ssid);
			buf[bp++] = WEXT_PNO_SSID_SECTION;
			buf[bp++] = ssid_conf->ssid_len;
			os_memcpy(&buf[bp], ssid_conf->ssid, ssid_conf->ssid_len);
			bp += ssid_conf->ssid_len;
			i++;
		}
		ssid_conf = ssid_conf->next;
	}

	buf[bp++] = WEXT_PNO_SCAN_INTERVAL_SECTION;
	os_snprintf(&buf[bp], WEXT_PNO_SCAN_INTERVAL_LENGTH + 1, "%x", WEXT_PNO_SCAN_INTERVAL);
	bp += WEXT_PNO_SCAN_INTERVAL_LENGTH;

	buf[bp++] = WEXT_PNO_REPEAT_SECTION;
	os_snprintf(&buf[bp], WEXT_PNO_REPEAT_LENGTH + 1, "%x", WEXT_PNO_REPEAT);
	bp += WEXT_PNO_REPEAT_LENGTH;

	buf[bp++] = WEXT_PNO_MAX_REPEAT_SECTION;
	os_snprintf(&buf[bp], WEXT_PNO_MAX_REPEAT_LENGTH + 1, "%x", WEXT_PNO_MAX_REPEAT);
	bp += WEXT_PNO_MAX_REPEAT_LENGTH + 1;

	os_memset(&iwr, 0, sizeof(iwr));
	os_strncpy(iwr.ifr_name, drv->ifname, IFNAMSIZ);
	iwr.u.data.pointer = buf;
	iwr.u.data.length = bp;

	ret = ioctl(drv->ioctl_sock, SIOCSIWPRIV, &iwr);

	if (ret < 0) {
		wpa_printf(MSG_ERROR, "ioctl[SIOCSIWPRIV] (pnosetup): %d", ret);
		drv->errors++;
		if (drv->errors > DRV_NUMBER_SEQUENTIAL_ERRORS) {
			drv->errors = 0;
			wpa_msg(drv->ctx, MSG_INFO, WPA_EVENT_DRIVER_STATE "HANGED");
		}
	} else {
		drv->errors = 0;
	}
	return ret;

}

int wpa_driver_wext_driver_cmd( void *priv, char *cmd, char *buf, size_t buf_len )
{
	struct wpa_driver_wext_data *drv = priv;
	struct wpa_supplicant *wpa_s = (struct wpa_supplicant *)(drv->ctx);
	struct iwreq iwr;
	int ret = 0, flags;

	wpa_printf(MSG_DEBUG, "%s %s len = %d", __func__, cmd, buf_len);

	if (!drv->driver_is_started && (os_strcasecmp(cmd, "START") != 0)) {
		wpa_printf(MSG_ERROR,"WEXT: Driver not initialized yet");
		return -1;
	}

	if (os_strcasecmp(cmd, "RSSI-APPROX") == 0) {
		os_strncpy(cmd, RSSI_CMD, MAX_DRV_CMD_SIZE);
	} else if( os_strncasecmp(cmd, "SCAN-CHANNELS", 13) == 0 ) {
		int no_of_chan;

		no_of_chan = atoi(cmd + 13);
		os_snprintf(cmd, MAX_DRV_CMD_SIZE, "COUNTRY %s",
			wpa_driver_get_country_code(no_of_chan));
	} else if (os_strcasecmp(cmd, "STOP") == 0) {
		linux_set_iface_flags(drv->ioctl_sock, drv->ifname, 0);
	} else if( os_strcasecmp(cmd, "RELOAD") == 0 ) {
		wpa_printf(MSG_DEBUG,"Reload command");
		wpa_msg(drv->ctx, MSG_INFO, WPA_EVENT_DRIVER_STATE "HANGED");
		return ret;
	} else if( os_strcasecmp(cmd, "BGSCAN-START") == 0 ) {
		ret = wpa_driver_set_backgroundscan_params(priv);
		if (ret < 0) {
			return ret;
		}
		os_strncpy(cmd, "PNOFORCE 1", MAX_DRV_CMD_SIZE);
		drv->bgscan_enabled = 1;
	} else if( os_strcasecmp(cmd, "BGSCAN-STOP") == 0 ) {
		os_strncpy(cmd, "PNOFORCE 0", MAX_DRV_CMD_SIZE);
		drv->bgscan_enabled = 0;
	}

	os_memset(&iwr, 0, sizeof(iwr));
	os_strncpy(iwr.ifr_name, drv->ifname, IFNAMSIZ);
	os_memcpy(buf, cmd, strlen(cmd) + 1);
	iwr.u.data.pointer = buf;
	iwr.u.data.length = buf_len;
/*
	if( os_strncasecmp(cmd, "CSCAN", 5) == 0 ) {
		if (!wpa_s->scanning && ((wpa_s->wpa_state <= WPA_SCANNING) ||
					(wpa_s->wpa_state >= WPA_COMPLETED))) {
			iwr.u.data.length = wpa_driver_wext_set_cscan_params(buf, buf_len, cmd);
		} else {
			wpa_printf(MSG_ERROR, "Ongoing Scan action...");
			return ret;
		}
	}
*/

	ret = ioctl(drv->ioctl_sock, SIOCSIWPRIV, &iwr);

	if (ret < 0) {
		wpa_printf(MSG_ERROR, "%s failed (%d): %s", __func__, ret, cmd);
		drv->errors++;
		if (drv->errors > WEXT_NUMBER_SEQUENTIAL_ERRORS) {
			drv->errors = 0;
			wpa_msg(drv->ctx, MSG_INFO, WPA_EVENT_DRIVER_STATE "HANGED");
		}
	} else {
		drv->errors = 0;
		ret = 0;
		if ((os_strcasecmp(cmd, RSSI_CMD) == 0) ||
		    (os_strcasecmp(cmd, LINKSPEED_CMD) == 0) ||
		    (os_strcasecmp(cmd, "MACADDR") == 0) ||
		    (os_strcasecmp(cmd, "GETPOWER") == 0) ||
		    (os_strcasecmp(cmd, "GETBAND") == 0)) {
			ret = strlen(buf);
		} else if (os_strcasecmp(cmd, "START") == 0) {
			drv->driver_is_started = TRUE;
			linux_set_iface_flags(drv->ioctl_sock, drv->ifname, 1);
			/* os_sleep(0, WPA_DRIVER_WEXT_WAIT_US);
			wpa_msg(drv->ctx, MSG_INFO, WPA_EVENT_DRIVER_STATE "STARTED"); */
		} else if (os_strcasecmp(cmd, "STOP") == 0) {
			drv->driver_is_started = FALSE;
			/* wpa_msg(drv->ctx, MSG_INFO, WPA_EVENT_DRIVER_STATE "STOPPED"); */
		}
/*
		else if (os_strncasecmp(cmd, "CSCAN", 5) == 0) {
			wpa_driver_wext_set_scan_timeout(priv);
			wpa_supplicant_notify_scanning(wpa_s, 1);
		}
*/
		wpa_printf(MSG_DEBUG, "%s %s len = %d, %d", __func__, buf, ret, strlen(buf));
	}
	return ret;
}

int wpa_driver_signal_poll(void *priv, struct wpa_signal_info *si)
{
	char buf[MAX_DRV_CMD_SIZE];
	struct wpa_driver_wext_data *drv = priv;
	char *prssi;
	int res;

	os_memset(si, 0, sizeof(*si));
	res = wpa_driver_wext_driver_cmd(priv, RSSI_CMD, buf, sizeof(buf));
	/* Answer: SSID rssi -Val */
	if (res < 0)
		return res;
	prssi = strcasestr(buf, RSSI_CMD);
	if (!prssi)
		return -1;
	si->current_signal = atoi(prssi + strlen(RSSI_CMD) + 1);

	res = wpa_driver_wext_driver_cmd(priv, LINKSPEED_CMD, buf, sizeof(buf));
	/* Answer: LinkSpeed Val */
	if (res < 0)
		return res;
	si->current_txrate = atoi(buf + strlen(LINKSPEED_CMD) + 1) * 1000;

	return 0;
}
