# Bluedroid: rc
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/bluetooth/init.qcom.bluedroid.rc:root/init.qcom.bluetooth.rc

PRODUCT_PACKAGES += \
    hwaddrs

# USBMS for recovery
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/recovery/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/lge/msm7x27-common/recovery/init.recovery.msm7x27.rc:root/init.recovery.$(CM_BUILD).rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/CHANGELOG-CM.txt:system/etc/CHANGELOG-CM.txt \
    $(LOCAL_PATH)/configs/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    $(LOCAL_PATH)/configs/adreno_config.txt:system/etc/adreno_config.txt \
    $(LOCAL_PATH)/configs/AudioFilter.csv:system/etc/AudioFilter.csv \
    $(LOCAL_PATH)/configs/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/configs/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    $(LOCAL_PATH)/configs/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/nvram.txt:system/etc/wl/nvram.txt \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

## swapart binary
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/swapart:system/bin/swapart

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.ap.interface=wl0.1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.camera=msm7x27 \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.3_r6 \
    ro.setupwizard.enable_bypass=1 \
    ro.telephony.call_ring.multiple=false

PRODUCT_PROPERTY_OVERRIDES += \
    debug.gr.numframebuffers=3

# Ramdisk
PRODUCT_PACKAGES += \
    init.swapart.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    ueventd.qcom.rc

# Audio
PRODUCT_PACKAGES += \
    audio_policy.msm7x27 \
    audio.primary.msm7x27

# Graphics & Media
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt

# Misc
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory \
    lights.msm7x27 \
    power.msm7x27 \
    lgapversion \
    libnetcmdiface

# GPS
PRODUCT_PACKAGES += \
    gps.default \
    librpc

# Build sim toolkit
PRODUCT_PACKAGES += \
    Stk

# Camera
PRODUCT_PACKAGES += \
    camera.msm7x27

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck \
    fibmap.f2fs \
    fsck.f2fs \
    make_ext4fs \
    mkfs.f2fs \
    resize2fs \
    setup_fs

# SELinux - we're not ready for enforcing mode yet
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.selinux=permissive

BOARD_SEPOLICY_DIRS += device/lge/msm7x27-common/sepolicy
BOARD_SEPOLICY_UNION += \
    file_contexts \
    genfs_contexts

# Offmode charging
#PRODUCT_PACKAGES += \
#    charger \
#    charger_res_images

# Development settings
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.debuggable=1 \
    ro.secure=0 \
    ro.allow.mock.location=0 \
    persist.service.adb.enable=1

# set default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Reduce background apps limit to 12 on low-tier devices
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.fw.bg_apps_limit=12

# Set max background services
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.max_starting_bg=6

# Inherit qcom/msm7x27
$(call inherit-product, device/qcom/msm7x27/msm7x27.mk)

# Install/Uninstall google apps
$(call inherit-product, vendor/google/gapps_armv6_tiny.mk)

# Dalvik
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=false \
    dalvik.vm.dexopt-data-only=1

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Common assets
PRODUCT_AAPT_CONFIG := normal mdpi hdpi
PRODUCT_LOCALES := en_US en_IN fr_FR it_IT es_ES et_EE de_DE nl_NL cs_CZ \
    pl_PL ja_JP zh_TW zh_CN zh_HK ru_RU ko_KR nb_NO es_US da_DK el_GR tr_TR \
    pt_PT pt_BR rm_CH sv_SE bg_BG ca_ES en_GB fi_FI hr_HR hu_HU in_ID iw_IL \
    lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA vi_VN tl_PH ar_EG fa_IR sw_TZ \
    ms_MY af_ZA zu_ZA en_XA ar_XB fr_CA mn_MN hy_AM az_AZ ka_GE

# lge msm7x27-common overlays
DEVICE_PACKAGE_OVERLAYS += device/lge/msm7x27-common/overlay
