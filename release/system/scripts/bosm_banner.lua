--[[
	BOSM Banner 1.0 LUA 5.2.1

	By XAN		16/09/2013
	Requested By SuperMario

	A script that displays a message banner for the fest BOSM.

	Command:
	+bosm_banner <banner_text>		- Displays the BOSM banner.	
]]

BOSM_ADMIN_IP_1 = "172.16.19.189"
BOSM_ADMIN_IP_2 = "172.16.20.183"
TOP_BORDER = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- BOSM 201X  l  GRITS . GUTS . GLORY -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n"
BOTTOM_BORDER = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 12)												-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(14)													-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1) .. "\r\n"
	
	if tUser.sIP == BOSM_ADMIN_IP_1 or tUser.sIP == BOSM_ADMIN_IP_2 then
		if cmd == "!bosm_banner" or cmd == "+bosm_banner" or cmd == "-bosm_banner" or cmd == "/bosm_banner" or cmd == "*bosm_banner" then		-- Confirm Command
			local bosm_banner = "\r\n" .. TOP_BORDER .. arg .. BOTTOM_BORDER
			Core.SendToAll(bosm_banner)
			return true
		end
	end
end