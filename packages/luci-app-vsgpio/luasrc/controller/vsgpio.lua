--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008 Jo-Philipp Wich <xm@leipzig.freifunk.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

VSGPIO Copyright 2010 Vision Systems GmbH
]]--
module("luci.controller.vsgpio", package.seeall)

--require("luci.fs")
--require("luci.http")

function index()
	require("onrisc")
	os=onrisc.onrisc_system_t()
	onrisc.onrisc_init(os)
	caps=onrisc.onrisc_get_dev_caps()
	if caps.gpios then
		local page = entry({"admin", "services", "vsgpio"}, cbi("vsgpio"), "GPIO", 10)
		page.dependent = false
		page.sysauth = {"root", "admin", "user"}

		entry({"admin", "services", "vsgpio", "data"}, call("vsgpio_getset", "data")).dependent = true
		entry({"admin", "services", "vsgpio", "ctrl"}, call("vsgpio_getset", "ctrl")).dependent = true

		local page2 = entry({"mini", "services", "vsgpio"}, cbi("vsgpio", {autoapply=true}), "GPIO", 10)
		page2.dependent = false

		entry({"mini", "services", "vsgpio", "data"}, call("vsgpio_getset", "data")).dependent = true
		entry({"mini", "services", "vsgpio", "ctrl"}, call("vsgpio_getset", "ctrl")).dependent = true
	end
end


function vsgpio_getset(filename)
	require("onrisc")
	local os=onrisc.onrisc_system_t()
	onrisc.onrisc_init(os)
	local caps=onrisc.onrisc_get_dev_caps()
	local fs = luci.fs or nixio.fs
	local tmp
	local tbl = { 0, 4, 6 }
	
	--Check if filename provided is valid
	if filename ~= "data" and filename ~= "ctrl" then
		return
	end
	
	--Initialize GPIOs
	--Nothing to do.

	luci.http.prepare_content("text/plain")

	--Get HTTP Vars
	local p = {}
	local mask = 0
	local value = 0
	local set = false
	local file
	local printstr = ""
	local data = false
	local err = "-"
	local pgroup = 0
	local pvar = 0

	--Import port values to array
	for i=0, caps.gpios.ngpio + caps.gpios.nvgpio - 1, 1 do
		pvar = luci.http.formvalue(string.format("p%d", i))
		if pvar and pvar:match("^[01]$") then
			if pvar == "1" then
				p[i] = 1
			else
				p[i] = 0
			end
		else
			p[i] = nil
		end
	end

	--set data of GPIO or ctrl direction
	for i=0, caps.gpios.ngpio + caps.gpios.nvgpio -1, 1 do
		if p[i] ~= nil then
			set = true
			if filename == "data" then
				local dir = onrisc.onrisc_gpios_t()
				dir.value = nixio.bit.bor(value, nixio.bit.lshift(p[i], i))
				dir.mask = nixio.bit.bor(value, nixio.bit.lshift(1, i))
				onrisc.onrisc_gpio_set_value(dir)
			else
				local dir = onrisc.onrisc_gpios_t()
				dir.value = nixio.bit.bor(value, nixio.bit.lshift(p[i], i))
				dir.mask = nixio.bit.bor(value, nixio.bit.lshift(1, i))
				onrisc.onrisc_gpio_set_direction(dir)
			end
		end
	end
	
	--read and return values
	if not set then
		if filename == "data" then
			local dir = onrisc.onrisc_gpios_t()
			onrisc.onrisc_gpio_get_value(dir)
			value = string.format("%08X", dir.value)
		else --ctrl
			local dir = onrisc.onrisc_gpios_t()
			onrisc.onrisc_gpio_get_direction(dir)
			value = string.format("%08X", dir.value)
	end
		luci.http.write(string.format("%s\n", value))
	end
end
