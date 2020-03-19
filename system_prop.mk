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

### System Properties for molly

## DRM
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true \
    ro.com.widevine.cachesize=16777216

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bt.bdaddr_path=/persist/bt_mac.txt

## GL/GPU
# Disable EGL_BUFFER_PRESERVED extension for OpenGLRenderer
# Use glcomposer as the default compositor
# GPU producer to CPU consumer not supported
# Set GL Version as per stock blobs
# Don't preload OpenGL in Zygote, the Tegra drivers do not like it
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false \
    persist.tegra.compositor=glcomposer \
    ro.bq.gpu_to_cpu_unsupported=1 \
    ro.opengles.version=131072 \
    ro.zygote.disable_gl_preload=true

## HDMI
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.display.resolution=1920x1080 \
    persist.sys.hdmi.resolution=Max \
    persist.tegra.hdmi.primary=1 \
    ro.hdmi.device_type=4 \
    ro.sf.lcd_density=320 \
    ro.sf.override_null_lcd_density=1 \

## NVMM
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.nvmmlite=1

## Stagefright
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true
    media.stagefright.cache-params=10240/20480/15 \
    media.stagefright.legacyencoder=true \
    media.stagefright.less-secure=true \
    persist.sys.media.avsync=true

## Vendor SPL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lineage.build.vendor_security_patch=2015-02-04

## Wi-Fi
PRODUCT_PROPERTY_OVERRIDES += \
    ap.interface=wlan0 \
    wifi.interface=wlan0
