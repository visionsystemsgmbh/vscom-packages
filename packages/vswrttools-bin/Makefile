include $(TOPDIR)/rules.mk

PKG_NAME:=vswrttools
PKG_VERSION:=1.0.8
PKG_RELEASE:=1

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vswrttools
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libonrisc +libuci
  TITLE:=VScom WRT Tools
  URL:=www.vscom.de
endef

define Package/vswrttools/description
  Collection of WRT related tools
endef

define Package/vswrttools/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) files/vscheckimg $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) files/onriscinfo $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) files/vsconfs $(1)/usr/bin/
endef

define Build/Compile
endef

define Build/Install
endef


$(eval $(call BuildPackage,vswrttools))

