$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/common/gps/gps_us_supl.mk)
$(call inherit-product, device/qcom/msm7x27/msm7x27.mk)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/releasetools/extras.sh:system/bin/extras.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/initlogo.rle:root/initlogo.rle \
    $(LOCAL_PATH)/root/init.qcom.rc:root/init.qcom.rc \
    $(LOCAL_PATH)/root/init.qcom.usb.rc:root/init.qcom.usb.rc \
    $(LOCAL_PATH)/root/init.qcom.sh:root/init.qcom.sh \
    $(LOCAL_PATH)/root/ueventd.qcom.rc:root/ueventd.qcom.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/CHANGELOG-CM.txt:system/etc/CHANGELOG-CM.txt \
    $(LOCAL_PATH)/configs/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    $(LOCAL_PATH)/configs/adreno_config.txt:system/etc/adreno_config.txt \
    $(LOCAL_PATH)/configs/AudioFilter.csv:system/etc/AudioFilter.csv \
    $(LOCAL_PATH)/configs/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/configs/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/nvram.txt:system/etc/wl/nvram.txt \
    $(LOCAL_PATH)/configs/vold.fstab:system/etc/vold.fstab \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.camera=msm7x27 \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.3_r6 \
    ro.setupwizard.enable_bypass=1 \
    ro.telephony.call_ring.multiple=false \
    ro.vold.umsdirtyratio=20

# Battery life hacks
PRODUCT_PROPERTY_OVERRIDES += \
    # Turn off RIL when not needed
    ro.ril.disable.power.collapse=1
    # Better sleep system
    pm.sleep_mode=1
    # Scan for WiFi less often to increase batery life
    wifi.supplicant_scan_interval=180

PRODUCT_PROPERTY_OVERRIDES += \
    com.qc.hdmi_out=false \
    debug.sf.hw=1 \
    debug.composition.type=mdp \
    debug.gr.numframebuffers=2 \
    persist.service.adb.enable=1

# Audio
PRODUCT_PACKAGES += \
    audio_policy.msm7x27 \
    audio.primary.msm7x27

# Media
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt

# Misc
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory \
    gps.default \
    lights.msm7x27 \
    lgapversion
    
# Build sim toolkit
PRODUCT_PACKAGES += \
    Stk
    
# Camera
PRODUCT_PACKAGES += \
    camera.msm7x27 \

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# BT startup
PRODUCT_COPY_FILES += $(LOCAL_PATH)/prebuilt/init.qcom.bt.sh:system/bin/init.qcom.bt.sh
PRODUCT_PACKAGES += \
    hcitool \
    hciconfig \
    hwaddrs

# Offmode charging
PRODUCT_PACKAGES += \
    charger \
    charger_res_images


PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

DEVICE_PACKAGE_OVERLAYS += device/lge/msm7x27-common/overlay
