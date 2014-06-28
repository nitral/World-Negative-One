--[[

	Phonebook 1.0 LUA 5.2.1

	By XAN			27/06/2014
	Requested By C@ve_Jh0ns0n

	A simple Lua script that lists emergency, important and frequently needed contacts by the users of the hub.
	
	Command:
	+phone			- Displays the Phonebook listing.
]]

-- Settings and Global Declarations
PHONEBOOK_PATH = ".\\scripts\\phonebook_files\\phonebook.txt"
HUB_BOT_NAME = "<[W-1]>"

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 6)								-- Strip Command from Chat Data

	if cmd == "!phone" or cmd == "+phone" or cmd == "-phone" or cmd == "/phone" or cmd == "*phone" then		-- Confirm Command
		local phonebook_listing = HUB_BOT_NAME .. " " .. getPhonebookListing()
		Core.SendToUser(tUser, phonebook_listing)
	end

end

-- Function to get Phonebook Listing
function getPhonebookListing()
	local file = io.open(PHONEBOOK_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end
