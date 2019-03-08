include $(TOPDIR)/rules.mk

PKG_NAME:=vsupnpd
PKG_VERSION:=0.4.0
PKG_RELEASE:=1

PKG_REV:=2438b3756a39c3e5612a86a1187060c189bdc9c0

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vsupnpd
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpthread +libonrisc
  TITLE:=VScom UPnP Daemon
  URL:=www.vscom.de
endef

define Package/vsupnpd/description
  VScom UPnP Daemon announces serial ports available for RFC2217 protocol.
endef

define Package/vsupnpd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) files/$(PKG_NAME) $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/$(PKG_NAME).init $(1)/etc/init.d/$(PKG_NAME)
endef

define Build/Compile
endef

define Build/Install
endef


$(eval $(call BuildPackage,vsupnpd))

