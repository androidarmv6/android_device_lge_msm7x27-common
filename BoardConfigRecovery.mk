DEVICE_RESOLUTION := 320x480
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"font_7x16.h\"
TARGET_NO_SEPARATE_RECOVERY := true
TARGET_NO_INITLOGO := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"

ifeq ($(RECOVERY_VARIANT),twrp)
TARGET_RECOVERY_FSTAB := device/lge/msm7x27-common/recovery/twrp.fstab
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_DISABLE_TTF := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := true
TW_MAX_BRIGHTNESS := 255
TW_NO_SCREEN_BLANK := true
else
TARGET_RECOVERY_FSTAB := device/lge/msm7x27-common/recovery/recovery.fstab
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/leds/lcd-backlight/brightness\"
endif

