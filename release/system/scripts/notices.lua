--[[
	
	Notices Display 1.0 LUA 5.2.1
	
	By XAN		07/09/2013
	Requested By Nephilim
	
	A simple Lua Script that displays notices when triggered to the user and some notices that are shown on connection.
	
	Command:
	+notices		- Displays the helpful information.
]]

-- Settings and Global Declarations
NOTICES_REQUEST_PATH = ""
NOTICES_CONNECT_PATH = ""
SOURCE_NICK = "World Negative 1 : Notice-Man"

function OnStartup()

	NOTICES_REQUEST_PATH = ".\\scripts\\notices_files\\notices_request.txt"
	NOTICES_CONNECT_PATH = ".\\scripts\\notices_files\\notices_connect.txt"

end

function UserConnected(tUser)
	
	local notices_connect = getNoticesConnect()
	Core.SendToUser(tUser, notices_connect)

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 8)									-- Strip Command from Chat Data

	if cmd == "!notices" or cmd == "+notices" or cmd == "-notices" or cmd == "/notices" or cmd == "*notices" then	-- Confirm Command
		local notices_request = getNoticesRequest()
		Core.SendPmToUser(tUser, SOURCE_NICK, notices_request)
		Core.SendToUser(tUser, "Notices have been sent to you via PM. Please check!")
	end

end

-- Function to get Notices sent on Connection of User
function getNoticesConnect()
	local file = io.open(NOTICES_CONNECT_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get Notices sent on Connection of User
function getNoticesRequest()
	local file = io.open(NOTICES_REQUEST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end