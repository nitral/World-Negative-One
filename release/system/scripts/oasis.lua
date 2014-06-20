--[[

	OASIS 2013 1.0 LUA 5.2.1

	By Ninja_XAN		16/10/2013
	Requested By SuperMario

	A script that makes commands related to the BITS-Pilani Fest OASIS.

	Command:
	+oasis				- Displays the day's OASIS happenings.
	+oasis help			- Displays a help box giving details of available commands and a small about section.
	+oasis fixtures		- Displays the fest's official fixtures of OASIS main events.
	+oasis gallery		- Displays a gallery of visual media related to the fest.
	+oasis logo			- Displays information and art related to the logo of the fest.
]]

-- Settings and Global Declarations
OASIS_PATH = ""
OASIS_HELP_PATH = ""
OASIS_FIXTURES_PATH = ""
OASIS_LOGO_INFO_PATH = ""
OASIS_LOGO_PATH = ""
OASIS_GALLERY_PATH = ""
OASIS_RESULTS = ""

-- Bot Settings
BOT_NAME = "[Oasis-BOT]"
BOT_DESC = "The Elements."
BOT_EMAIL = ""
BOT_HAVE_KEY = true

OASIS_YAWP = "<" .. BOT_NAME .. "> Oasis - 2013   I   The Elements   I   43rd Annual Cultural Festival"

function OnStartup()

	OASIS_PATH = ".\\scripts\\oasis_files\\oasis.txt"
	OASIS_HELP_PATH = ".\\scripts\\oasis_files\\oasis_help.txt"
	OASIS_FIXTURES_PATH = ".\\scripts\\oasis_files\\oasis_fixtures.txt"
	OASIS_LOGO_INFO_PATH = ".\\scripts\\oasis_files\\oasis_logo_info.txt"
	OASIS_LOGO_PATH = ".\\scripts\\oasis_files\\oasis_logo.txt"
	OASIS_GALLERY_PATH = ".\\scripts\\oasis_files\\oasis_gallery.txt"
	OASIS_RESULTS_PATH = ".\\scripts\\oasis_files\\oasis_results.txt"

	-- Register BOSM Bot --
	Core.RegBot(BOT_NAME, BOT_DESC, BOT_EMAIL, BOT_HAVE_KEY)

end

function ChatArrival(tUser, sData)

	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 6)									-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(8)										-- Strip maximum possible argument length from Chat Data

	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1)

	if cmd == "!oasis" or cmd == "+oasis" or cmd == "-oasis" or cmd == "/oasis" or cmd == "*oasis" then		-- Confirm Command

		-- Lookup Argument passed and get content from corresponding file
		if string.sub(arg, 1, 4) == "help" then
			local oasis_help = getOasisHelp()
			Core.SendToUser(tUser, oasis_help)
		elseif string.sub(arg, 1, 7) == "fixture" then
			local oasis_fixtures = getOasisFixtures()
			local pm_popup = "<" .. BOT_NAME .. "> Fixtures have been sent to you via PM. Please Check!"
			Core.SendToUser(tUser, pm_popup)
			Core.SendPmToUser(tUser, BOT_NAME, oasis_fixtures)
		elseif string.sub(arg, 1, 7) == "results" then
			local oasis_results = getOasisResults()
			local pm_popup = "<" .. BOT_NAME .. "> Results have been sent to you via PM. Please Check!"
			Core.SendToUser(tUser, pm_popup)
			Core.SendPmToUser(tUser, BOT_NAME, oasis_results)
		elseif string.sub(arg, 1, 4) == "logo" then
			local oasis_logo = getOasisLogo()
			local oasis_logo_info = getOasisLogoInfo()
			local pm_popup = "<" .. BOT_NAME .. "> Oasis - 2013 Logo have been sent to you via PM. Please Check!"
			Core.SendToUser(tUser, pm_popup)
			Core.SendToUser(tUser, oasis_logo_info)
			Core.SendPmToUser(tUser, BOT_NAME, oasis_logo)
		elseif string.sub(arg, 1, 7) == "gallery" then
			local oasis_gallery = getOasisGallery()
			Core.SendToUser(tUser, oasis_gallery)
		elseif arg == "" then
			local oasis = getOasis()
			Core.SendToAll(OASIS_YAWP)
			Core.SendToUser(tUser, oasis)
		end
	end

end

-- Function to get Oasis Help Info
function getOasisHelp()
	local file = io.open(OASIS_HELP_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get Oasis Fixtures Info
function getOasisFixtures()
	local file = io.open(OASIS_FIXTURES_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get Oasis Results Info
function getOasisResults()
	local file = io.open(OASIS_RESULTS_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end


-- Function to get Oasis Logo
function getOasisLogo()
	local file = io.open(OASIS_LOGO_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get Oasis Logo Info
function getOasisLogoInfo()
	local file = io.open(OASIS_LOGO_INFO_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get Oasis Gallery
function getOasisGallery()
	local file = io.open(OASIS_GALLERY_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get Oasis Main Command Info
function getOasis()
	local file = io.open(OASIS_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end
