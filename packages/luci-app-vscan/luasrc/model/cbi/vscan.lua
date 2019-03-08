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

m = Map("slcantcp", translate("NetCAN"), translate("TCP/IP to CAN Bus Gateway settings."))

s = m:section(TypedSection, "iface", translate("Interfaces"))
s.anonymous = true
--s:option(DummyValue, translate("dev"), translate("CAN Device"))
s:option(Value, translate("port"), translate("TCP Port"))

return m

