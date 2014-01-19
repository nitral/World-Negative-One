--[[
	
	Uploads List 1.0 LUA 5.2.1
	
	By XAN		07/09/2013
	Requested By Nephilim
	
	A simple script that shows the stored uploads list to the user.
	
	Command:
	+uploads		- Displays the stored uploads list.
]]

-- Settings and Global Declarations
UPLOADS_LIST_PATH = ""

function OnStartup()

	UPLOADS_LIST_PATH = ".\\scripts\\uploads_list_files\\uploads_list.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 8)									-- Strip Command from Chat Data

	if cmd == "!uploads" or cmd == "+uploads" or cmd == "-uploads" or cmd == "/uploads" or cmd == "*uploads" then	-- Confirm Command
		local uploads_list = getUploadsList()
		Core.SendToUser(tUser, uploads_list)
	end

end

-- Function to get Uploads List Content
function getUploadsList()
	local file = io.open(UPLOADS_LIST_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end