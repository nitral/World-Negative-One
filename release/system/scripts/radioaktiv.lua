--[[
	
	RadioAKTIV 1.0 LUA 5.2.1
	
	By XAN		10/09/2013
	Requested By RadioAKTIV
	
	A script that displays a message board by Radioaktiv club.
	
	Command:
	+radioaktiv			- Displays the message board.	
]]

-- Settings and Global Declarations
RADIOAKTIV_PATH = ""

function OnStartup()

	RADIOAKTIV_PATH = ".\\scripts\\radioaktiv_files\\radioaktiv.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 11)												-- Strip Command from Chat Data
	
	if cmd == "!radioaktiv" or cmd == "+radioaktiv" or cmd == "-radioaktiv" or cmd == "/radioaktiv" or cmd == "*radioaktiv" then		-- Confirm Command
		local radioaktiv_content = getRadioaktivContent()
		Core.SendToUser(tUser, radioaktiv_content)
	end

end

-- Function to get Radioaktiv Content
function getRadioaktivContent()
	local file = io.open(RADIOAKTIV_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end