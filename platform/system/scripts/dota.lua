--[[
	
	DOTA Server Scanner 1.0 LUA 5.2.1
	
	By XAN		20/09/2013
	Requested By XAN
	
	A script that displays the currently active DOTA Servers on LAN.
	
	Command:
	+dota				- Displays the DOTA Servers List.
]]

-- Settings and Global Declarations
DOTA_SERVER_LIST_PATH = ""

function OnStartup()

	DOTA_SERVER_LIST_PATH = ".\\scripts\\dota_files\\dota.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 5)										-- Strip Command from Chat Data
	
	if cmd == "!dota" or cmd == "+dota" or cmd == "-dota" or cmd == "/dota" or cmd == "*dota" then					-- Confirm Command
		local dota_server_list = getDOTAServerList()
		Core.SendToUser(tUser, dota_server_list)
	end

end

-- Function to get DOTA Server List
function getDOTAServerList()
	local file = io.open(DOTA_SERVER_LIST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end