include $(TOPDIR)/rules.mk

PKG_NAME:=vsscripts
PKG_VERSION:=1.1.2
PKG_RELEASE:=2

include $(INCLUDE_DIR)/package.mk

define Package/vsscripts
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=
  TITLE:=VScom Scripts
  URL:=www.vscom.de
endef

define Package/vsscripts/description
  VScom Scripts like onrisc and udev stuff.
endef

define Build/Compile
endef

define Package/vsscripts/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) files/onrisc $(1)/etc/init.d/onrisc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) files/vsnet $(1)/etc/init.d/vsnet
endef
$(eval $(call BuildPackage,vsscripts))

