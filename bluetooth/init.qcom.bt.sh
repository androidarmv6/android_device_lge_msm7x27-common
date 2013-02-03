#!/system/bin/sh

BLUETOOTH_SLEEP_PATH=/proc/bluetooth/sleep/proto
LOG_TAG="qcom-bluetooth"
LOG_NAME="${0}:"

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  setprop bluetooth.status off;
  exit $2
}

setprop bluetooth.status off

# echo 1 > $BLUETOOTH_SLEEP_PATH

/system/bin/brcm_patchram_plus -d --patchram /etc/firmware/BCM4325D1_004.002.004.0218.0248.hcd /dev/ttyHS0
logi "Setting baudrate..."
/system/bin/brcm_patchram_plus -d -baudrate 3000000 /dev/ttyHS0 
exit_code_hci_qcomm_download=$?

case $exit_code_hci_qcomm_download in
  0) logi "Bluetooth QSoC firmware download succeeded, $BTS_DEVICE $BTS_TYPE $BTS_BAUD $BTS_ADDRESS";;
  *) failed "Bluetooth QSoC firmware download failed" $exit_code_hci_qcomm_download;;
esac

setprop bluetooth.status on

logi "start bluetooth transport"

exit 0
