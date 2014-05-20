--[[
	
	Call of Duty Server Scanner 1.0 LUA 5.2.1
	
	By XAN		11/09/2013
	Requested By XAN
	
	A script that displays the currently active Call of Duty Servers on LAN.
	
	Command:
	+cod				- Displays the Call of Duty Servers List.
]]

-- Settings and Global Declarations
COD_SERVER_LIST_PATH = ""

function OnStartup()

	COD_SERVER_LIST_PATH = ".\\scripts\\cod_files\\cod.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 4)										-- Strip Command from Chat Data
	
	if cmd == "!cod" or cmd == "+cod" or cmd == "-cod" or cmd == "/cod" or cmd == "*cod" then					-- Confirm Command
		local cod_server_list = getCODServerList()
		Core.SendToUser(tUser, cod_server_list)
	end

end

-- Function to get CS Server List
function getCODServerList()
	local file = io.open(COD_SERVER_LIST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end