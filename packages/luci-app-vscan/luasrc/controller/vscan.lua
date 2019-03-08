--[[

LuCI vsvpn
(c) 2013 Vision Systems GmbH <contact@visionsystems.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: vsvpn.lua 9558 2012-12-18 13:58:22Z jow $

]]--

module("luci.controller.vscan", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/slcantcp") then
		return
	end
	if not nixio.fs.stat("/sys/class/net/can0") then
		return
	end

	local page

	page = entry({"admin", "services", "vscan"}, cbi("vscan"), _("NetCAN"), 31)
	page.dependent = false

	local page2

	page2 = entry({"mini", "services", "vscan"}, cbi("vscan", {autoapply=true}), _("NetCAN"), 31)
	page2.dependent = false
end
