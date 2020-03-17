# Copyright (C) 2021 The LineageOS Project
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

# Inherit common device specific configuration
$(call inherit-product, device/google/molly/device.mk)

# Inherit Google base ATV configuration
$(call inherit-product, device/google/atv/products/atv_base.mk)

# Inherit common Lineage configuration for tablets
$(call inherit-product, vendor/cm/config/common_full_tv.mk)

# Boot Animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920

PRODUCT_NAME := lineage_molly
PRODUCT_DEVICE := molly
PRODUCT_BRAND := google
PRODUCT_MODEL := ADT-1
PRODUCT_MANUFACTURER := Google

PRODUCT_GMS_CLIENTID_BASE := android-google

# Device Fingerprint
BUILD_FINGERPRINT := google/molly/molly:5.0.2/LRX22G/1649326:user/release-keys

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=molly \
    PRIVATE_BUILD_DESC="molly-user 5.0.2 LRX22G 1649326 release-keys"

# Inherit proprietary vendor
$(call inherit-product-if-exists, vendor/google/molly/molly-vendor.mk)
