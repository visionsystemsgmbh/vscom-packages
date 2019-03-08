--[[

LuCI serial-mode
(c) 2013 Vision Systems GmbH <contact@visionsysmtes.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: serial_modes.lua 9558 2012-12-18 13:58:22Z jow $

]]--

module("luci.controller.netcom", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/netcom") then
		return
	end

	local page

	page = entry({"admin", "services", "netcom"}, cbi("netcom"), _("NetCom"), 30)
	page.dependent = false

	entry({"mini", "services", "netcom"}, cbi("netcom", {autoapply=true}), _("NetCom"), 30).dependent = false

end
