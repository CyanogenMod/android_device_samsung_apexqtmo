# Copyright (C) 2009 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
USE_CAMERA_STUB := true

# Temporary GPS fix. Must be called here as it fixes GPS called from
# MSM8960-common. Works in conjunction with older d2 GPS blob

common_flags += -DSET_PRIVACY

# inherit from the proprietary version
-include vendor/samsung/apexqtmo/BoardConfigVendor.mk
# inherit from common msm8960
-include device/samsung/msm8960-common/BoardConfigCommon.mk

# Assert
TARGET_OTA_ASSERT_DEVICE := apexqtmo

# Kernel
TARGET_KERNEL_SOURCE        := kernel/samsung/apexq
TARGET_KERNEL_CONFIG        := cyanogen_apexq_defconfig
BOARD_KERNEL_CMDLINE        := androidboot.hardware=qcom user_debug=31 zcache
BOARD_KERNEL_BASE           := 0x80200000
BOARD_MKBOOTIMG_ARGS        := --ramdisk_offset 0x01300000
BOARD_KERNEL_PAGESIZE       := 2048

TARGET_BOOTLOADER_BOARD_NAME := MSM8260A

# Recovery
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/samsung/apexqtmo/recovery/recovery_keys.c
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_15x24.h\"
BOARD_USES_MMCUTILS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB := device/samsung/apexqtmo/recovery.fstab

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00A00000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00A00000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1572864000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 28651290624
BOARD_FLASH_BLOCK_SIZE := 131072

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/apexqtmo/bluetooth
BOARD_HAVE_BLUETOOTH_BCM :=
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# Disable initlogo, Samsungs framebuffer is weird
TARGET_NO_INITLOGO := true

# HAX
#BOARD_USE_SAMSUNG_SEPARATEDSTREAM := true
#BOARD_USES_LIBMEDIA_WITH_AUDIOPARAMETER := true
#TARGET_PROVIDES_LIBAUDIO := true
TARGET_USES_QCOM_COMPRESSED_AUDIO := true
BOARD_USES_SEPERATED_VOICE_SPEAKER := true
BOARD_HAVE_AUDIENCE_A2220 := false
BOARD_USES_FLUENCE_INCALL := false

# Use USB Dock Audio
BOARD_HAVE_DOCK_USBAUDIO := true

# Wifi
WIFI_BAND := 802_11_ABG
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HAVE_SAMSUNG_WIFI :=
BOARD_HAS_QCOM_WLAN := true

WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/prima_wlan.ko"
WIFI_DRIVER_MODULE_NAME     := "prima_wlan"
#WIFI_DRIVER_MODULE_ARG      :=
#WIFI_DRIVER_MODULE_AP_ARG   :=
#WIFI_DRIVER_FW_PATH_PARAM   :=
#WIFI_DRIVER_FW_PATH_STA     := "sta"
#WIFI_DRIVER_FW_PATH_AP      := "ap"
#WIFI_DRIVER_FW_PATH_P2P     :=

