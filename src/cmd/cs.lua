--[[
	
	Counter Strike Server Scanner 1.0 LUA 5.2.1
	
	By XAN		11/09/2013
	Requested By XAN
	
	A script that displays the currently active Counter Strike 1.6 Servers on LAN.
	
	Command:
	+cs				- Displays the Counter Strike Servers List.
]]

-- Settings and Global Declarations
CS_SERVER_LIST_PATH = ""

function OnStartup()

	CS_SERVER_LIST_PATH = ".\\scripts\\cs_files\\cs.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 3)										-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(5)										-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1)
	
	if cmd == "!cs" or cmd == "+cs" or cmd == "-cs" or cmd == "/cs" or cmd == "*cs" then					-- Confirm Command
		if arg == "" then
			local cs_server_list = getCSServerList()
			Core.SendToUser(tUser, cs_server_list)
		end
	end

end

-- Function to get CS Server List
function getCSServerList()
	local file = io.open(CS_SERVER_LIST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end