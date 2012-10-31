$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/common/gps/gps_us_supl.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# Hardware
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml

# Extras script
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/releasetools/extras.sh:system/bin/extras.sh
    
# Media
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/prebuilt/system/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt \
    device/lge/msm7x27-common/prebuilt/system/etc/media_codecs.xml:system/etc/media_codecs.xml \
    device/lge/msm7x27-common/prebuilt/system/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/lge/msm7x27-common/prebuilt/system/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/lge/msm7x27-common/prebuilt/system/etc/audio_policy.conf:system/etc/audio_policy.conf \
    
# Wi-Fi
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/prebuilt/system/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf
    
# Vold
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/prebuilt/system/etc/vold.fstab:system/etc/vold.fstab

# Root
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/prebuilt/root/initlogo.rle:root/initlogo.rle \
    device/lge/msm7x27-common/prebuilt/root/init.qcom.rc:root/init.qcom.rc \
    device/lge/msm7x27-common/prebuilt/root/init.qcom.usb.rc:root/init.qcom.usb.rc \
    device/lge/msm7x27-common/prebuilt/root/init.qcom.sh:root/init.qcom.sh \
    device/lge/msm7x27-common/prebuilt/root/ueventd.qcom.rc:root/ueventd.qcom.rc

# Post-boot script
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/prebuilt/system/etc/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh

# Misc
PRODUCT_COPY_FILES += \
    device/lge/msm7x27-common/prebuilt/system/usr/keylayout/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    device/lge/msm7x27-common/prebuilt/system/etc/adreno_config.txt:system/etc/adreno_config.txt \
    device/lge/msm7x27-common/prebuilt/system/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/lge/msm7x27-common/prebuilt/system/etc/wl/nvram.txt:system/etc/wl/nvram.txt \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.camera=msm7x27 \
    debug.camcorder.disablemeta=1 \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.com.google.gmsversion=2.3_r6 \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y \
    ro.telephony.call_ring.multiple=false \
    ro.vold.umsdirtyratio=20

PRODUCT_PROPERTY_OVERRIDES += \
    com.qc.hardware=true \
    com.qc.hdmi_out=false \
    debug.sf.hw=1 \
    debug.enabletr=false \
    debug.composition.type=mdp \
    debug.gr.numframebuffers=2 \
    debug.qctwa.statusbar=1 \
    debug.qctwa.preservebuf=1 \
    hwui.render_dirty_regions=false \
    hwui.disable_vsync=true \
    hwui.print_config=choice \
    persist.sys.strictmode.visual=false

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=true \
    media.stagefright.enable-scan=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-record=true

# Audio
PRODUCT_PACKAGES += \
    audio_policy.msm7x27 \
    audio.primary.msm7x27 \
    audio.a2dp.default \
    libaudioutils

# Display
PRODUCT_PACKAGES += \
    libgenlock \
    libmemalloc \
    liboverlay \
    libqdutils \
    libtilerenderer \
    libopencorehw \
    gralloc.msm7x27 \
    copybit.msm7x27 \
    hwcomposer.msm7x27

# Media (no support for msm7x27 in JB)
#PRODUCT_PACKAGES += \
#    libstagefrighthw \
#    libmm-omxcore \
#    libOmxCore \

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
    LegacyCamera

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# BT startup
PRODUCT_COPY_FILES += $(LOCAL_PATH)/prebuilt/system/bin/init.qcom.bt.sh:system/bin/init.qcom.bt.sh
PRODUCT_PACKAGES += \
    hcitool \
    hciconfig \
    hwaddrs


PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

DEVICE_PACKAGE_OVERLAYS += device/lge/msm7x27-common/overlay
