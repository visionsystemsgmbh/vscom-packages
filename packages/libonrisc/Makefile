include $(TOPDIR)/rules.mk

PKG_NAME:=libonrisc
PKG_VERSION:=1.5.4
PKG_RELEASE:=1

PKG_REV:=203e4c01feb14ee87f8ddb602ce0bb6fb128978f

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/visionsystemsgmbh/libonrisc.git
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=+swig/host
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += -DPYTHON_WRAP=OFF -DLUA_WRAP=ON

define Package/libonrisc
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libpthread +libsoc +udev +lua
  TITLE:=OnRISC API Library
  URL:=www.vscom.de
endef

define Package/libonrisc/description
  OnRISC API Library
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/onrisc/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/onrisc.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libonrisc.so* $(1)/usr/lib/
endef

define Package/libonrisc/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libonrisc.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/luaonrisc.so $(1)/usr/lib/lua/onrisc.so
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/onrisctool $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/onriscdipd $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/onriscgpiod $(1)/usr/bin/
endef
$(eval $(call BuildPackage,libonrisc))

