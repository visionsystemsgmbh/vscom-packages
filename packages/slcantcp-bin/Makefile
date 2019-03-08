include $(TOPDIR)/rules.mk

PKG_NAME:=slcantcp
PKG_VERSION:=1.7
PKG_RELEASE:=1

PKG_REV:=$(PKG_VERSION)

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/slcantcp
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread +libstdcpp +zlog +libsocketcan +libonrisc
  TITLE:=SLCAN TCP Daemon
  URL:=www.vscom.de
endef

define Package/slcantcp/description
  SLCAN TCP Daemon.
endef

define Package/slcantcp/conffiles
/etc/config/slcantcp
endef

define Package/slcantcp/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) files/$(PKG_NAME) $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/$(PKG_NAME).config $(1)/etc/config/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/$(PKG_NAME).init $(1)/etc/init.d/$(PKG_NAME)
	$(LN) -s /tmp $(1)/parameter
endef 

define Build/Compile
endef

define Build/Install
endef

$(eval $(call BuildPackage,slcantcp))

