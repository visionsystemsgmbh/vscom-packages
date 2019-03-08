--[[

LuCI vscan
(c) 2014 Vision Systems GmbH <contact@visionsystems.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: vscan.lua 6063 2010-04-14 08:58:08Z ben $

]]--

require("nixio.fs")
local uci = require "luci.model.uci".cursor()
local machine = uci:get_first("onrisc","system","machine")

m = Map("gpio", "", "")

m:section(SimpleSection).template = "vsgpio"

s = m:section(TypedSection, "config", translate("Settings"))
s.anonymous = true
s:option(Flag, translate("extender"), translate("Use DIO Extender"))

if machine == "viavpn" then
	s:option(Flag, translate("viavpnsw"), translate("Allow viaVPN switch off by IN3"))
end

s:option(Value, translate("port"), translate("MODBUS/TCP Port"))

return m

