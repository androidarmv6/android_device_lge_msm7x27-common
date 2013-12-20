# Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## BlueZ support
## Note: needs to be defined here in order to satisfy inheritance issues.
## If disabled, Bluedroid will be used.
#BOARD_HAVE_BLUETOOTH_BLUEZ := true

ifdef BOARD_HAVE_BLUETOOTH_BLUEZ
# BlueZ: binaries
PRODUCT_PACKAGES += \
    bluetoothd \
    brcm_patchram_plus \
    libbluetoothd \
    hcitool \
    hciconfig \
    hciattach

# BlueZ: configs
PRODUCT_COPY_FILES += \
    system/bluetooth/data/audio.conf:system/etc/bluetooth/audio.conf \
    system/bluetooth/data/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    system/bluetooth/data/blacklist.conf:system/etc/bluetooth/blacklist.conf \
    system/bluetooth/data/input.conf:system/etc/bluetooth/input.conf \
    system/bluetooth/data/main.le.conf:system/etc/bluetooth/main.conf \
    system/bluetooth/data/network.conf:system/etc/bluetooth/network.conf

# BlueZ: javax.btobex is required by Bluetooth_msm
PRODUCT_PACKAGES += \
    javax.btobex

# BlueZ: rc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bluetooth/init.qcom.bluez.rc:root/init.qcom.bluetooth.rc

else

# Bluedroid: rc
PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/bluetooth/init.qcom.bluedroid.rc:root/init.qcom.bluetooth.rc

endif #BOARD_HAVE_BLUETOOTH_BLUEZ

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bluetooth/init.qcom.bt.sh:system/bin/init.qcom.bt.sh

PRODUCT_PACKAGES += \
    hwaddrs


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
    $(LOCAL_PATH)/configs/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/nvram.txt:system/etc/wl/nvram.txt \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/default.prop:root/default.prop

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
    com.qc.hdmi_out=false \
    debug.sf.hw=1 \
    debug.composition.type=mdp \
    debug.gr.numframebuffers=3 \
    persist.sys.purgeable_assets=1 \
    persist.service.adb.enable=1
    
# Ramdisk
PRODUCT_PACKAGES += \
    initlogo.rle \
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
    lgapversion
    
# GPS
PRODUCT_PACKAGES += \
    gps.default \
    librpc
    
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

# Use set_perm (no selinux version) instead of set_metadata (selinux version)
#USE_SET_METADATA := false

# KitKat uses selinux enforcing mode by default
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.selinux=permissive

# Offmode charging
#PRODUCT_PACKAGES += \
#    charger \
#    charger_res_images

# Inherit qcom/msm7x27
$(call inherit-product, device/qcom/msm7x27/msm7x27.mk)

# Install/Uninstall google apps
$(call inherit-product, vendor/google/gapps_armv6_tiny.mk)

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=false \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.dexopt-flags=v=a,o=v,m=y,u=y

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# Common assets
PRODUCT_AAPT_CONFIG := normal mdpi hdpi

# lge msm7x27-common overlays
DEVICE_PACKAGE_OVERLAYS += device/lge/msm7x27-common/overlay
