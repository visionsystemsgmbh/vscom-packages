--[[

LuCI serial-mode
(c) 2013 Vision Systems GmbH <contact@visionsysmtes.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: serial_mode.lua 6063 2010-04-14 08:58:08Z ben $

]]--

require("nixio.fs")
--require("bit")
require("onrisc")

function get_rsmodes()
	os=onrisc.onrisc_system_t()
	onrisc.onrisc_init(os)
	caps=onrisc.onrisc_get_dev_caps()
	uart={}
	if nixio.bit.band(caps.uarts.flags,onrisc.UARTS_SWITCHABLE) ~= 1 then
		for i=1,caps.uarts.num do
			uart[i]=1
		end
	end

	if nixio.bit.band(caps.uarts.flags,onrisc.UARTS_DIPS_PHYSICAL) == 2 then
		local trans={5,1,4,3,6,6,6,2,6,6,10,9,7,6,6,8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7}
		for i=1,caps.uarts.num do
			local val
			err,val=onrisc.onrisc_get_uart_mode_raw(i)
			uart[i]=trans[val+1]
		end
	else
		local trans={5,1,6,4,11,2,6,3,6,6,6,10,7,8,6,9}
		local val
		err,val=onrisc.onrisc_get_dips()
		for i=1,caps.uarts.num do
			uart[i]=trans[val+1]
		end
	end
end

local uci = require "luci.model.uci".cursor()

local onrisc_cnf = uci:get("onrisc", "OnRISC", "SystemId")

get_rsmodes()

m = Map("netcom", translate("NetCom"), translate("TCP/IP to Serial Gateway configuration."))

s = m:section(TypedSection, "iface", translate("Interfaces"))

--s:option(DummyValue, "dev", translate("Serial Device"))
devt = s:option(DummyValue, "devtype", translate("Device Type"))
devt.template = "cbi/hvalue"
pd = s:option(DummyValue, "mode2", translate("DIP-Mode"))
pd:depends("devtype", "internal")
--pd:value("loop", translate("loopback mode"))

function pd.cfgvalue(self, section)
	local port_nr = tonumber(string.sub(section,4))	
	local rsmodes = {"RS-232 (active)", "RS-422 (active)", "RS-485 full duplex (active)", "RS-485 half duplex (active)", "loopback mode (active)", "Unknown mode","Selected by software", "RS-422 with termination (active)", "RS-485 full duplex with termination (active)", "RS-485 half duplex with termination (active)", "Web frontend export"}
	local res = rsmodes[uart[port_nr]]
	return res
end

p = s:option(ListValue, "mode", translate("Mode"))
if onrisc_cnf == "1" or onrisc_cnf == "2" or onrisc_cnf == "3" then
	p:value("rs232", "rs232")
	p:value("rs422", "rs422")
	p:value("rs485byart-4-wire", "rs485byart-4-wire")
	p:value("rs485byart-2-wire-noecho", "rs485byart-2-wire-noecho")
	p:value("rs485byart-2-wire-echo", "rs485byart-2-wire-echo")
	p:value("rs485byrts-4-wire", "rs485byrts-4-wire")
	p:value("rs485byrts-2-wire-noecho", "rs485byrts-2-wire-noecho")
	p:value("rs485byrts-2-wire-echo", "rs485byrts-2-wire-echo")
	p:value("inactive", "inactive")
else
	p:value("rs232", "RS-232")
	p:value("rs422", "RS-422")
	p:value("rs422-term", translate("RS-422 with termination"))
	p:value("rs485-fd", translate("RS-485 full duplex"))
	p:value("rs485-fd-term", translate("RS-485 full duplex with termination"))
	p:value("rs485-hd", translate("RS-485 half duplex"))
	p:value("rs485-hd-term", translate("RS-485 half duplex with termination"))
	if nixio.bit.band(caps.uarts.flags,onrisc.UARTS_DIPS_PHYSICAL) ~= 0 then
		p:value("dip", translate("DIP switches configured mode"))
	end
	p:value("loop", translate("loopback mode"))
end

s:option(Value, "tcpport", translate("TCP Port"))

p1 = s:option(ListValue, "telprot", translate("Telnet Protocol"))
p1:value("telnet", "RFC2217")
p1:value("raw", "TCP raw")

s:option(Value, "timeout", translate("Telnet Timeout"))

pb = s:option(Value, "baudrate", translate("Baudrate"))
pb:depends("telprot", "raw")
pb:value("300", "300")
pb:value("600", "600")
pb:value("1200", "1200")
pb:value("2400", "2400")
pb:value("4800", "4800")
pb:value("9600", "9600")
pb:value("19200", "19200")
pb:value("38400", "38400")
pb:value("57600", "57600")
pb:value("115200", "115200")
pb:value("230400", "230400")
pb:value("460800", "460800")
pb:value("500000", "500000")
pb:value("576000", "576000")
pb:value("921600", "921600")
pb:value("1000000", "1000000")
pb:value("1152000", "1152000")
pb:value("1500000", "1500000")
pb:value("2000000", "2000000")
pb:value("2500000", "2500000")
pb:value("3000000", "3000000")

p2 = s:option(ListValue, "databit", translate("DataBit"))
p2:depends("telprot", "raw")
p2:value("8DATABITS", "8")
p2:value("7DATABITS", "7")

p3 = s:option(ListValue, "parity", translate("Parity"))
p3:depends("telprot", "raw")
p3:value("NONE", translate("None"))
p3:value("EVEN", translate("Even"))
p3:value("ODD", translate("Odd"))

p4 = s:option(ListValue, "stopbit", translate("StopBit"))
p4:depends("telprot", "raw")
p4:value("1STOPBIT", "1")
p4:value("2STOPBITS", "2")

p5 = s:option(ListValue, "flowtype", translate("FlowType"))
p5:depends("telprot", "raw")
p5:value("-XONXOFF -RTSCTS", translate("None"))
p5:value("XONXOFF -RTSCTS", "XON/XOFF")
p5:value("-XONXOFF RTSCTS", "RTS/CTS")

return m

