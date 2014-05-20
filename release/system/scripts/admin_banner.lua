--[[
	Admin Banner 1.0 LUA 5.2.1

	By XAN		14/09/2013
	Requested By XAN

	A script that displays a message banner.

	Command:
	+admin_banner <banner_text>		- Displays the admin banner.	
]]

ADMIN_IP_1 = "172.16.19.189"
ADMIN_IP_2 = "172.16.20.183"
ADMIN_IP_3 = "172.16.16.85"
TOP_BORDER = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- WORLD NEGATIVE ONE -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n"
BOTTOM_BORDER = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-"

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 13)												-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(15)													-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1) .. "\r\n"
	
	if tUser.sIP == ADMIN_IP_1 or tUser.sIP == ADMIN_IP_2 or tUser.sIP == ADMIN_IP_3 then
		if cmd == "!admin_banner" or cmd == "+admin_banner" or cmd == "-admin_banner" or cmd == "/admin_banner" or cmd == "*admin_banner" then		-- Confirm Command
			local admin_banner = "\r\n" .. TOP_BORDER .. arg .. BOTTOM_BORDER
			Core.SendToAll(admin_banner)
			return true
		end
	end
end