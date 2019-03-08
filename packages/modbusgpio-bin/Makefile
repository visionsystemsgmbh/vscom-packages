include $(TOPDIR)/rules.mk

PKG_NAME:=modbusgpio
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_REV:=19e2b592844fc413669f4aba7dea1607238eccae

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/modbusgpio
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libmodbus +libonrisc
  TITLE:=VScom Modbus-GPIO Daemon
  URL:=www.vscom.de
endef

define Package/modbusgpio/description
  VScom Modbus-GPIO Daemon.
endef

define Package/modbusgpio/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) files/$(PKG_NAME) $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/$(PKG_NAME).init $(1)/etc/init.d/$(PKG_NAME)
endef

define Build/Compile
endef

define Build/Install
endef


$(eval $(call BuildPackage,modbusgpio))

