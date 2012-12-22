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

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
USE_CAMERA_STUB := true

# Use the Qualcomm common folder
include device/qcom/msm7x27/BoardConfigCommon.mk

## Camera
TARGET_DISABLE_ARM_PIE := true
BOARD_NEEDS_MEMORYHEAPPMEM := true
BOARD_USE_NASTY_PTHREAD_CREATE_HACK := true
COMMON_GLOBAL_CFLAGS += -DBINDER_COMPAT
#BOARD_USES_LEGACY_CAMERA := true
#BOARD_CPU_COLOR_CONVERT := true

## Kernel
TARGET_KERNEL_SOURCE := kernel/lge/msm7x27
# Copy LG Kernel Headers here if necessary, DO NOT use Android auto-generated headers
TARGET_SPECIFIC_HEADER_PATH := device/lge/msm7x27-common/include
BOARD_KERNEL_CMDLINE := mem=471M console=ttyMSM2,115200n8 androidboot.hardware=qcom

## CPU & Platform
ARCH_ARM_HAVE_VFP := true
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200

## Browser & WebKit
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true

## Boot loader & recovery
TARGET_NO_BOOTLOADER := true
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

## Partition Sizes
# Fix this up by examining /proc/mtd on a running device
BOARD_KERNEL_BASE := 0x12800000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00440000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00500000
# Ignore that this is much larger than the 190Mb allowed.
# It's only for resolving build issues with the system.img
# being too big. It will still be only about 100MB MAXIMUM
# because all the useless trash is now in extras
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0xE600000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x0c780000
BOARD_FLASH_BLOCK_SIZE := 131072

## Graphics
# Force non usage of VSync
TARGET_USE_OVERLAY := false
TARGET_HAVE_BYPASS := false
TARGET_USES_SF_BYPASS := false
BOARD_EGL_NEEDS_LEGACY_FB := true
TARGET_DISABLE_TRIPLE_BUFFERING := true
BOARD_EGL_CFG := device/lge/msm7x27-common/configs/egl.cfg
# Framerate
COMMON_GLOBAL_CFLAGS += -DREFRESH_RATE=60

## Qualcomm and Adreno Hardware
BOARD_USE_ADRENO_200_GPU := true
TARGET_QCOM_DISPLAY_VARIANT := true
COMMON_GLOBAL_CFLAGS += -DANCIENT_GL

## GPS
# Enable the GPS HAL & AMSS version to use for GPS
BOARD_USES_QCOM_LIBRPC := true
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000

## Lights
TARGET_PROVIDES_LIBLIGHTS := true

## Audio, Bluetooth & FM Radio
TARGET_PROVIDES_LIBAUDIO := true
BOARD_USES_AUDIO_LEGACY := false
BOARD_COMBO_DEVICE_SUPPORTED := true
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
# BOARD_FM_DEVICE := bcm4325
# BOARD_HAVE_FM_RADIO := true
# Use the second one (QCOM_FM_ENABLED) not the first
# The first breaks the builds and the second is more
# recent and is used in the CM code
# COMMON_GLOBAL_CFLAGS += -DHAVE_FM_RADIO
# COMMON_GLOBAL_CFLAGS += -DQCOM_FM_ENABLED

## RIL
BOARD_PROVIDES_LIBRIL := true

## Mass Storage for Jelly Bean
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun/file
BOARD_UMS_LUNFILE := /sys/class/android_usb/android0/f_mass_storage/lun/file

## Touch screen compatibility for Jelly Bean
BOARD_USE_LEGACY_TOUCHSCREEN := true

## Wi-Fi & Wi-Fi HotSpot
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WLAN_DEVICE := ath6kl
WIFI_AP_DRIVER_MODULE_ARG := "ifname=athap0 fwmode=2"
WIFI_AP_DRIVER_MODULE_PATH := /system/wifi/ar6000.ko
WIFI_AP_DRIVER_MODULE_NAME := ar6000
WIFI_DRIVER_MODULE_ARG := "ifname=wlan0 fwmode=1"
WIFI_DRIVER_MODULE_PATH := /system/wifi/ar6000.ko
WIFI_DRIVER_MODULE_NAME := ar6000
BOARD_HAVE_LEGACY_HOSTAPD := true
BOARD_HOSTAPD_NO_ENTROPY := true

## OTA script
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := device/lge/msm7x27-common/releasetools/ota_from_target_files
