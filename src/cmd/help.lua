--[[
	
	Help Information 1.0 LUA 5.2.1
	
	By XAN		07/09/2013
	Requested By Nephilim
	
	A simple Lua script that displays some helpful information to the user.
	
	Command:
	+help			- Displays the helpful information.
]]

-- Settings and Global Declarations
HELP_INFO_PATH = ""

function OnStartup()

	HELP_INFO_PATH = ".\\scripts\\help_info_files\\help_info.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 5)									-- Strip Command from Chat Data

	if cmd == "!help" or cmd == "+help" or cmd == "-help" or cmd == "/help" or cmd == "*help" then			-- Confirm Command
		local help_info = getHelpInfo()
		Core.SendToUser(tUser, help_info)
	end

end

-- Function to get Help Information Content
function getHelpInfo()
	local file = io.open(HELP_INFO_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end