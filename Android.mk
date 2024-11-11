#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter a70q a70s,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.

MODEM_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware-modem
$(MODEM_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(MODEM_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware-mode

ALL_DEFAULT_INSTALLED_MODULES += $(MODEM_MOUNT_POINT)

WLANMDSP_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlanmdsp.mbn
$(WLANMDSP_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WLANMDSP config ini link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/firmware_mnt/image/$(notdir $@) $@

WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini
$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS config ini link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/firmware/wlan/qca_cld/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK)

endif
