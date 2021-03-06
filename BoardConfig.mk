# Copyright (C) 2020 The LineageOS Project
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
# limitations under the License
# inherit from the proprietary version

DEVICE_PATH := device/google/molly

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a15
TARGET_EXCLUDES_AUDIOFX := true
TARGET_TEGRA_VERSION := t124

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true

# Audio
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MRVL := true

# Board
TARGET_BOARD_PLATFORM := tegra4
TARGET_BOOTLOADER_BOARD_NAME := molly
TARGET_NO_BOOTLOADER := true

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
    endif
  endif
endif

# Alphabetized as "D" for "Dlmalloc"
# Use dlmalloc
MALLOC_IMPL := dlmalloc

# Graphics
# CFLAGS: Disable Secure Discard
# CFLAGS: Disable ashmem tracking to prevent GL crash
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD -DDISABLE_ASHMEM_TRACKING
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 1
USE_OPENGL_RENDERER := true

# Kernel
BOARD_KERNEL_CMDLINE := androidboot.hardware=molly console=ttyFIQ0 smsc95xx.boot_wol_config=0x07 smsc95xx.turbo_mode=N androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage
KERNEL_TOOLCHAIN_PREFIX := arm-eabi-
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/arm/arm-eabi-4.8/bin
TARGET_KERNEL_CONFIG := molly_defconfig
TARGET_KERNEL_SOURCE := kernel/google/molly

# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 734003200
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13912506368

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/fstab.molly

# Seccomp
BOARD_SECCOMP_POLICY := $(DEVICE_PATH)/seccomp

# SELinux
BOARD_SEPOLICY_DIRS := $(DEVICE_PATH)/sepolicy

# Wi-Fi
BOARD_HAVE_MARVELL_WIFI          := true
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_mrvl
BOARD_WLAN_DEVICE                := mrvl
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mrvl
CONFIG_CTRL_IFACE                := y
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/mrvl/sd8797_uapsta.bin"
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/mrvl/sd8797_uapsta.bin"
WPA_SUPPLICANT_VERSION           := VER_0_8_X

# Inherit from the proprietary board configuration
include vendor/google/molly/BoardConfigVendor.mk
