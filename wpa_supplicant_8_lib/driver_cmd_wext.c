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

int wpa_driver_wext_driver_cmd( void *priv, char *cmd, char *buf, size_t buf_len )
{
	int ret = 0;

	wpa_printf(MSG_DEBUG, "%s %s len = %d", __func__, cmd, buf_len);

	if ((os_strcasecmp(cmd, RSSI_CMD) == 0) ||
	    (os_strcasecmp(cmd, LINKSPEED_CMD) == 0) ||
	    (os_strcasecmp(cmd, "MACADDR") == 0) ||
	    (os_strcasecmp(cmd, "GETPOWER") == 0) ||
	    (os_strcasecmp(cmd, "GETBAND") == 0))
	{

		struct wpa_driver_wext_data *drv = priv;
		struct wpa_supplicant *wpa_s = (struct wpa_supplicant *)(drv->ctx);
		struct iwreq iwr;

		os_memset(&iwr, 0, sizeof(iwr));
		os_strncpy(iwr.ifr_name, drv->ifname, IFNAMSIZ);
		os_memcpy(buf, cmd, strlen(cmd) + 1);
		iwr.u.data.pointer = buf;
		iwr.u.data.length = buf_len;

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
			ret = strlen(buf);

			wpa_printf(MSG_DEBUG, "%s %s len = %d, %d", __func__, buf, ret, strlen(buf));
		}
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
