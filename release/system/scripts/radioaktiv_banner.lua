--[[
	
	RadioAKTIV Banner 1.0 LUA 5.2.1
	
	By XAN		10/09/2013
	Requested By RadioAKTIV
	
	A script that displays a message board by Radioaktiv club.
	
	Command:
	+radioaktiv_banner <banner>		- Displays the banner for RadioAKTIV.	
]]

RADIOAKTIV_IP_1 = "172.16.20.203"
RADIOAKTIV_IP_2 = "172.16.19.197"
ADMIN_IP_1 = "172.16.20.183"
ADMIN_IP_2 = "172.16.19.189"
TOP_BORDER = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- RADIOAKTIV -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\r\n"
BOTTOM_BORDER = "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-"

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 18)												-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(20)												-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1) .. "\r\n"
	
	if tUser.sIP == RADIOAKTIV_IP_1 or tUser.sIP == RADIOAKTIV_IP_2 or tUser.sIP == ADMIN_IP_1 or tUser.sIP == ADMIN_IP_2 then
		if cmd == "!radioaktiv_banner" or cmd == "+radioaktiv_banner" or cmd == "-radioaktiv_banner" or cmd == "/radioaktiv_banner" or cmd == "*radioaktiv_banner" then		-- Confirm Command
			local radioaktiv_banner = "\r\n" .. TOP_BORDER .. arg .. BOTTOM_BORDER
			Core.SendToAll(radioaktiv_banner)

			return true
		end
	end
end