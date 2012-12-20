ifeq (LGE,$(PRODUCT_MANUFACTURER))
  ifeq (msm7x27,$(TARGET_BOARD_PLATFORM))
    # HACK for prebuilt libril and libcamera
    $(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libril_intermediates)
    $(shell touch $(OUT)/obj/SHARED_LIBRARIES/libril_intermediates/export_includes)
    $(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libcamera_intermediates)
    $(shell touch $(OUT)/obj/SHARED_LIBRARIES/libcamera_intermediates/export_includes)

    include $(call all-makefiles-under,$(call my-dir))
  endif
endif
