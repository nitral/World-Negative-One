--[[
	
	Babaji Ka Thullu List 1.0 LUA 5.2.1
	
	By XAN		13/11/2013
	Requested By DeViL
	
	A simple script that shows content related to the show Comedy Nights With Kapil.
	
	Command:
	+thullu		- Displays the Content related to Comedy Nights With Kapil.
]]

-- Settings and Global Declarations
THULLU_PATH = ""

function OnStartup()

	THULLU_PATH = ".\\scripts\\thullu_files\\thullu.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 7)									-- Strip Command from Chat Data

	if cmd == "!thullu" or cmd == "+thullu" or cmd == "-thullu" or cmd == "/thullu" or cmd == "*thullu" then		-- Confirm Command
		local thullu_contents = getThullu()
		Core.SendToUser(tUser, thullu_contents)
	end

end

-- Function to get Thullu Content
function getThullu()
	local file = io.open(THULLU_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end
