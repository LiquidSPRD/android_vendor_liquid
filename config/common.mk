PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/liquid/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/liquid/prebuilt/common/bin/50-liquid.sh:system/addon.d/50-liquid.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# CM's specific init file
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/liquid/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/liquid/prebuilt/common/bin/sysinit:system/bin/sysinit

# SuperSU
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    vendor/liquid/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Layers
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/Layers.apk:system/app/Layers/Layers.apk \
	vendor/liquid/prebuilt/common/etc/Layersbackup.apk:system/app/Layersbackup/Layersbackup.apk

# Kernel Auditor
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/etc/Kerneladiutor.apk:system/app/Auditor/Kerneladiutor.apk

# No Icon for Layers App
PRODUCT_PROPERTY_OVERRIDES += \
    ro.layers.noIcon=noIcon

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    SlimLauncher \
    Apollo \
    CMFileManager \
    LatinIME \
    BluetoothExt \
    DashClock \
    DeskClock \
    Terminal \
    LockClock \
    AudioFX \
    KernelAdiutor

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libstagefright_soft_ffmpegadec \
    libstagefright_soft_ffmpegvdec \
    libFFmpegExtractor \
    media_codecs_ffmpeg.xml

# Root access on by default
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/liquid/overlay/common

# bootanimation
PRODUCT_COPY_FILES += \
    vendor/liquid/prebuilt/common/bootanimation/bootanimation.zip:system/media/bootanimation.zip

# Version
RELEASE = false
LIQUID_VERSION_MAJOR = 6
LIQUID_VERSION_MINOR = 0
#LIQUID_VARIANT = layers

# release
ifeq ($(RELEASE),true)
    LIQUID_VERSION := LS-MM-MileStone-$(LIQUID_VERSION_MAJOR).$(LIQUID_VERSION_MINOR)-$(LIQUID_VARIANT)
else
    LIQUID_VERSION_STATE := $(shell date +%Y-%m-%d)
    LIQUID_VERSION := LS-MM-v$(LIQUID_VERSION_MAJOR).$(LIQUID_VERSION_MINOR)-$(LIQUID_VARIANT)-$(LIQUID_VERSION_STATE)
endif

# HFM Files
PRODUCT_COPY_FILES += \
	vendor/liquid/prebuilt/etc/hosts.alt:system/etc/hosts.alt \
	vendor/liquid/prebuilt/etc/hosts.og:system/etc/hosts.og

# statistics identity
PRODUCT_PROPERTY_OVERRIDES += \
    ro.romstats.url=http://stats.liquidsmooth.net/ \
    ro.romstats.name=LiquidSmooth \
    ro.romstats.version=$(LIQUID_VERSION) \
    ro.romstats.askfirst=0 \
    ro.romstats.tframe=1

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.liquid.version=$(LIQUID_VERSION)
