BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"font_7x16.h\"

TARGET_NO_INITLOGO := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/leds/lcd-backlight/brightness\"

BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/lge/msm7x27-common/recovery/recovery_keys.c

TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := true
TW_MAX_BRIGHTNESS := 255
TW_NO_SCREEN_BLANK := true
