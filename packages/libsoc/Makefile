#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsoc
PKG_VERSION:=0.8.2
PKG_RELEASE:=1

PKG_REV:=$(PKG_VERSION)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/jackmitch/libsoc.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libsoc
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread
  TITLE:=SoC Library
  URL:=https://github.com/jackmitch/libsoc
endef

define Package/libsoc/description
  libsoc: C library for interfacing with common SoC peripherals through
  generic kernel interfaces
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-cxx

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	DESTDIR="$(PKG_INSTALL_DIR)" \
	all install

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/libsoc/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libsoc_gpio.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsoc.{a,so} $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsoc.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/share/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libsoc.pc $(1)/usr/share/pkgconfig
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libsoc.pc $(1)/usr/lib/pkgconfig
endef

define Package/libsoc/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsoc.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libsoc))
