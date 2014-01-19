--[[
	
	Counter Strike Global Offensive Server Scanner 1.0 LUA 5.2.1
	
	By XAN		20/09/2013
	Requested By XAN
	
	A script that displays the currently active Counter Strike Global Offensive Servers on LAN.
	
	Command:
	+csgo				- Displays the Counter Strike Servers List.
]]

-- Settings and Global Declarations
CSGO_SERVER_LIST_PATH = ""

function OnStartup()

	CSGO_SERVER_LIST_PATH = ".\\scripts\\csgo_files\\csgo.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 5)										-- Strip Command from Chat Data
	
	if cmd == "!csgo" or cmd == "+csgo" or cmd == "-csgo" or cmd == "/csgo" or cmd == "*csgo" then					-- Confirm Command
		local csgo_server_list = getCSGOServerList()
		Core.SendToUser(tUser, csgo_server_list)
	end

end

-- Function to get CSGOServer List
function getCSGOServerList()
	local file = io.open(CSGO_SERVER_LIST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end