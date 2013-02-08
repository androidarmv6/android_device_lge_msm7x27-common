#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the Qualcomm common folder
include device/qcom/msm7x27/BoardConfigCommon.mk

## Boot loader & recovery
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
BOARD_HAS_NO_SELECT_BUTTON := true

## Kernel
#BUILD_WITH_30X_KERNEL := true
ifdef BUILD_WITH_30X_KERNEL
TARGET_KERNEL_SOURCE := kernel/lge/msm7x27-3.0.x
else
TARGET_KERNEL_SOURCE := kernel/lge/msm7x27
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.4.3
endif
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom
BOARD_KERNEL_BASE := 0x12800000
BOARD_KERNEL_PAGESIZE := 2048

## *** Copy LG Kernel Headers here if necessary, DO NOT use Android auto-generated headers ***
TARGET_SPECIFIC_HEADER_PATH := device/lge/msm7x27-common/include

## Partition Sizes: Fix this up by examining /proc/mtd on a running device
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00440000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00500000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0xff00000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x0c780000
BOARD_FLASH_BLOCK_SIZE := 131072

## Graphics
BOARD_EGL_NEEDS_LEGACY_FB := true
TARGET_DISABLE_TRIPLE_BUFFERING := true
TARGET_NO_HW_VSYNC := true
COMMON_GLOBAL_CFLAGS += -DANCIENT_GL

## Camera
BOARD_USE_NASTY_PTHREAD_CREATE_HACK := true
COMMON_GLOBAL_CFLAGS += -DBINDER_COMPAT

## Audio & FM Radio
BOARD_COMBO_DEVICE_SUPPORTED := true
# BOARD_FM_DEVICE := bcm4325
# BOARD_HAVE_FM_RADIO := true
# COMMON_GLOBAL_CFLAGS += -DHAVE_FM_RADIO
# COMMON_GLOBAL_CFLAGS += -DQCOM_FM_ENABLED

## Wi-Fi & Wi-Fi HotSpot
WPA_SUPPLICANT_VERSION          := VER_0_8_X
BOARD_WLAN_DEVICE               := bcm4325
BOARD_WEXT_NO_COMBO_SCAN        := true
BOARD_WPA_SUPPLICANT_DRIVER     := WEXT
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
WIFI_DRIVER_HAS_LGE_SOFTAP      := true
WIFI_DRIVER_MODULE_PATH         := "/system/lib/modules/wireless.ko"
WIFI_DRIVER_MODULE_ARG          := "firmware_path=/etc/wl/rtecdc.bin nvram_path=/etc/wl/nvram.txt config_path=/data/misc/wifi/config"
WIFI_DRIVER_MODULE_NAME         := "wireless"
WIFI_DRIVER_FW_PATH_STA         := "/system/etc/wl/rtecdc.bin"
WIFI_DRIVER_FW_PATH_AP          := "/system/etc/wl/rtecdc-apsta.bin"

## Bluetooth
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := device/lge/msm7x27-common/bluetooth/libbt_lge.txt

## GPS
BOARD_USES_QCOM_LIBRPC := true
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE_LEGACY := msm7x27 # don't use hardware/qcom/gps version yet

## RIL
BOARD_PROVIDES_LIBRIL := true

## Lights
TARGET_PROVIDES_LIBLIGHT := true

## Mass Storage
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun/file
BOARD_UMS_LUNFILE := /sys/class/android_usb/android0/f_mass_storage/lun/file

## Touch screen compatibility
BOARD_USE_LEGACY_TOUCHSCREEN := true

## Minimal fonts
SMALLER_FONT_FOOTPRINT := true

## Browser & WebKit
ENABLE_WEBGL := true

## OTA script extras file (build/tools/releasetools)
TARGET_OTA_EXTRAS_FILE := device/lge/msm7x27-common/releasetools/extras.txt
