ifeq (LGE,$(PRODUCT_MANUFACTURER))
  ifeq (msm7x27,$(TARGET_BOARD_PLATFORM))
    include $(call all-makefiles-under,$(call my-dir))
  endif
endif
