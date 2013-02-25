LOCAL_PATH:= $(call my-dir)

ifneq ($(USE_CAMERA_STUB),true)
ifeq ($(strip $(BOARD_USES_QCOM_HARDWARE)), true)
BUILD_LIBCAMERA:=true
ifeq ($(BUILD_LIBCAMERA),true)

# When zero we link against libmmcamera; when 1, we dlopen libmmcamera.
DLOPEN_LIBMMCAMERA:=1

ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

# hax for libmmjpeg
$(shell mkdir -p $(OUT)/obj/SHARED_LIBRARIES/libmmjpeg_intermediates)
$(shell touch $(OUT)/obj/SHARED_LIBRARIES/libmmjpeg_intermediates/export_includes)


LOCAL_CFLAGS:= -DDLOPEN_LIBMMCAMERA=$(DLOPEN_LIBMMCAMERA)

ifeq ($(strip $(TARGET_USES_ION)),true)
LOCAL_CFLAGS += -DUSE_ION
endif

LOCAL_CFLAGS+= -DHW_ENCODE

LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

ifeq ($(call is-board-platform,msm8960),true)
LOCAL_HAL_FILES := QCameraHAL.cpp QCameraHWI_Parm.cpp\
                   QCameraHWI.cpp QCameraHWI_Preview.cpp \
                   QCameraHWI_Record.cpp QCameraHWI_Still.cpp \
                   QCameraHWI_Mem.cpp QCameraHWI_Display.cpp \
                   QCameraStream.cpp QualcommCamera2.cpp QCameraParameters.cpp
MM_CAM_FILES:=
else
LOCAL_HAL_FILES := QualcommCamera.cpp QualcommCameraHardware.cpp QCameraParameters.cpp
MM_CAM_FILES:=
endif

#yyan if debug service layer and up , use stub camera!
LOCAL_C_INCLUDES += \
        frameworks/base/services/camera/libcameraservice #

LOCAL_SRC_FILES := $(MM_CAM_FILES) $(LOCAL_HAL_FILES)




ifeq ($(call is-chipset-prefix-in-board-platform,msm7627),true)
LOCAL_CFLAGS+= -DNUM_PREVIEW_BUFFERS=6 -D_ANDROID_
else
LOCAL_CFLAGS+= -DNUM_PREVIEW_BUFFERS=4 -D_ANDROID_
endif

# To Choose neon/C routines for YV12 conversion
LOCAL_CFLAGS+= -DUSE_NEON_CONVERSION
# Uncomment below line to enable smooth zoom
#LOCAL_CFLAGS+= -DCAMERA_SMOOTH_ZOOM

LOCAL_C_INCLUDES+= \
    $(TARGET_OUT_HEADERS)/mm-camera \
    $(TARGET_OUT_HEADERS)/mm-camera/common \
    $(TARGET_OUT_HEADERS)/mm-still \
    $(TARGET_OUT_HEADERS)/mm-still/jpeg \

ifeq ($(call is-board-platform,msm8960),true)
LOCAL_C_INCLUDES+= $(TARGET_OUT_HEADERS)/mm-core/omxcore
LOCAL_C_INCLUDES+= $(TARGET_OUT_HEADERS)/mm-still/mm-omx
endif

LOCAL_C_INCLUDES+= $(LOCAL_PATH)/mm-camera-interface
LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include/media
LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
LOCAL_C_INCLUDES += hardware/qcom/display/libgralloc \
                    hardware/qcom/display/libgenlock \
                    hardware/qcom/media/libstagefrighthw

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

ifeq ($(call is-board-platform,msm8960),true)
LOCAL_SHARED_LIBRARIES:= libutils libui libcamera_client liblog libcutils libmmjpeg
else
LOCAL_SHARED_LIBRARIES:= libutils libui libcamera_client liblog libcutils libmmjpeg
endif

LOCAL_SHARED_LIBRARIES += libmmcamera_interface2
LOCAL_SHARED_LIBRARIES+= libgenlock libbinder
ifneq ($(DLOPEN_LIBMMCAMERA),1)
LOCAL_SHARED_LIBRARIES+= liboemcamera
else
LOCAL_SHARED_LIBRARIES+= libdl
endif

LOCAL_CFLAGS += -include bionic/libc/kernel/common/linux/socket.h

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE:= camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif # BUILD_TINY_ANDROID
endif # BUILD_LIBCAMERA
endif # BOARD_USES_QCOM_HARDWARE
endif # USE_CAMERA_STUB

ifeq ($(call is-board-platform,msm8960),true)
include $(LOCAL_PATH)/mm-camera-interface/Android.mk
endif
