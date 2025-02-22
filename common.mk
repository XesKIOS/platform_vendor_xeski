PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0

# Backup Tool
#PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/xeski/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/xeski/prebuilt/common/bin/blacklist:system/addon.d/blacklist \
    vendor/xeski/prebuilt/common/bin/whitelist:system/addon.d/whitelist \

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# SuperSU
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    vendor/xeski/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# init.d support
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/xeski/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/xeski/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/etc/init.local.rc:root/init.local.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/xeski/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/xeski/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Browser \
    libemoji \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    powertop \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    Terminal \
    WallpaperPicker

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# RCS
PRODUCT_PACKAGES += \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# Snapdragon packages
PRODUCT_PACKAGES += \
    MusicFX \
    SnapdragonCamera \
    SnapdragonGallery \
    SnapdragonMusic

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# OMS
PRODUCT_PACKAGES += \
    masquerade

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    SoundRecorder

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# World APN list
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += \
	vendor/xeski/overlay/common

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter arm64,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/xeski/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif


# Squisher Location
SQUISHER_SCRIPT := vendor/xeski/tools/squisher

# XesKiOS Versioning
ANDROID_VERSION = 7.1.1
PLATFORM_VERSION_CODENAME = REL

ifndef XESKI_BUILD_TYPE
ifeq ($(XESKI_RELEASE),OFFICIAL)
    XESKI_BUILD_TYPE := OFFICIAL
    PLATFORM_VERSION_CODENAME := OFFICIAL
else
    XESKI_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif
endif

ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    XESKI_BUILD_TYPE := $(TARGET_UNOFFICIAL_BUILD_ID)
endif
XESKI_VER := $(XESKI_BUILD_TYPE)
XESKI_VERSION_NUMBER := 1.0

# Set all versions
XESKI_VERSION := XesKiOS-$(ANDROID_VERSION)-$(shell date +%Y%m%d)-$(XESKI_VER)
XESKI_MOD_VERSION := XesKiOS-$(ANDROID_VERSION)-$(shell date +%Y%m%d)-$(XESKI_VER)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.xeski.version=$(XESKI_VERSION_NUMBER)-$(XESKI_VER)

$(call inherit-product-if-exists, vendor/extra/product.mk)
