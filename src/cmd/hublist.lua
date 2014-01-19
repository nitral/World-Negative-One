--[[
	
	Hublist 1.0 LUA 5.2.1
	
	By XAN		07/09/2013
	Requested By Nephilim
	
	A simple Lua script that displays the stored hublist.
	
	Command:
	+hublist			- Displays the stored hublist.
]]

-- Settings and Global Declarations
HUBLIST_PATH = ""

function OnStartup()

	HUBLIST_PATH = ".\\scripts\\hublist_files\\hublist.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 8)										-- Strip Command from Chat Data
	
	if cmd == "!hublist" or cmd == "+hublist" or cmd == "-hublist" or cmd == "/hublist" or cmd == "*hublist" then		-- Confirm Command
		local hublist = getHublist()
		Core.SendToUser(tUser, hublist)
	end

end

-- Function to get Hublist Content
function getHublist()
	local file = io.open(HUBLIST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end