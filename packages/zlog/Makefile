#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zlog
PKG_VERSION:=1.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/HardySimpson/zlog.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=13904dab2878aa2654d0c20fb8600a3dc5f2dd68
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/zlog
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread
  TITLE:=Logging Library
  URL:=https://github.com/HardySimpson/zlog
endef

define Package/zlog/description
  A reliable, high-performance, thread safe, flexsible, clear-model,
  pure C logging library.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/zlog/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/zlog.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libzlog.{a,so} $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libzlog.so* $(1)/usr/lib/
endef

define Build/Install
	$(call Build/Install/Default,PREFIX=$(PKG_INSTALL_DIR)/usr install)
endef

define Package/zlog/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libzlog.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,zlog))

