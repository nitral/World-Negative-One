--[[
	
	Hubsite 1.0 LUA 5.2.1
	
	By XAN		09/10/2013
	Requested By XAN
	
	A simple Lua script that displays stored information regarding the hub's website.
	
	Command:
	+hubsite			- Displays the stored information.
	+site				- Displays the stored information.
]]

-- Settings and Global Declarations
HUBSITE_PATH = ""

function OnStartup()

	HUBSITE_PATH = ".\\scripts\\hubsite_files\\hubsite.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd1 = string.gsub(sData, "%b<> ", ""):sub(1, 8)										-- Strip Command from Chat Data
	local cmd2 = string.gsub(sData, "%b<> ", ""):sub(1,5)										-- Strip Command from Chat Data
	
	if cmd1 == "!hubsite" or cmd1 == "+hubsite" or cmd1 == "-hubsite" or cmd1 == "/hubsite" or cmd1 == "*hubsite" or cmd2 == "!site" or cmd2 == "+site" or cmd2 == "-site" or cmd2 == "/site" or cmd2 == "*site" then		-- Confirm Command
		local hubsite_info = getHubsiteInfo()
		Core.SendToUser(tUser, hubsite_info)
	end

end

-- Function to get Hubsite Content
function getHubsiteInfo()
	local file = io.open(HUBSITE_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end