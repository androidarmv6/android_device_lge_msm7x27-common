ifneq ($(BOARD_HAVE_BLUETOOTH_BCM4325),)
  include $(call all-named-subdir-makefiles,libbt-vendor)
endif # BOARD_HAVE_BLUETOOTH_BCM4325
