# Copyright 2006 The Android Open Source Project

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES:= \
    ril.cpp \
    ril_event.cpp

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libutils \
    libbinder \
    libcutils \
    libhardware_legacy

LOCAL_CFLAGS :=

LOCAL_MODULE:= libril

include $(BUILD_SHARED_LIBRARY)
