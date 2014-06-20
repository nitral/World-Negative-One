--[[
	
	BOSM 2013 1.0 LUA 5.2.1
	
	By Ninja_XAN		16/09/2013
	Requested By SuperMario
	
	A script that makes commands related to the BITS-Pilani Fest BOSM.
	
	Command:
	+bosm				- Displays the day's BOSM happenings.
	+bosm help			- Displays a help box giving details of available commands and a small about section.
	+bosm fixtures		- Displays the fest's official fixtures of BOSM main events.
	+bosm results		- Displays the results of the fest main events.
	+bosm gallery		- Displays a gallery of visual media related to the fest.
	+bosm logo			- Displays information and art related to the logo of the fest.
	
]]

-- Settings and Global Declarations
BOSM_PATH = ""
BOSM_HELP_PATH = ""
BOSM_FIXTURES_PATH = ""
BOSM_RESULTS_PATH = ""
BOSM_LOGO_INFO_PATH = ""
BOSM_LOGO_PATH = ""
BOSM_GALLERY_PATH = ""

-- Bot Settings
BOT_NAME = "[BOSM-BOT]"
BOT_DESC = "GRITS.GUTS.GLORY l BOSM - 2013"
BOT_EMAIL = ""
BOT_HAVE_KEY = true

BOSM_YAWP = "<" .. BOT_NAME .. "> BOSM - 2013   l   GRITS . GUTS . GLORY "

function OnStartup()

	BOSM_PATH = ".\\scripts\\bosm_files\\bosm.txt"
	BOSM_HELP_PATH = ".\\scripts\\bosm_files\\bosm_help.txt"
	BOSM_FIXTURES_PATH = ".\\scripts\\bosm_files\\bosm_fixtures.txt"
	BOSM_RESULTS_PATH = ".\\scripts\\bosm_files\\bosm_results.txt"
	BOSM_LOGO_INFO_PATH = ".\\scripts\\bosm_files\\bosm_logo_info.txt"
	BOSM_LOGO_PATH = ".\\scripts\\bosm_files\\bosm_logo.txt"
	BOSM_GALLERY_PATH = ".\\scripts\\bosm_files\\bosm_gallery.txt"

	-- Register BOSM Bot --
	Core.RegBot(BOT_NAME, BOT_DESC, BOT_EMAIL, BOT_HAVE_KEY)

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 5)									-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(7)										-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1)
	
	if cmd == "!bosm" or cmd == "+bosm" or cmd == "-bosm" or cmd == "/bosm" or cmd == "*bosm" then		-- Confirm Command
	
		-- Lookup Argument passed and get content from corresponding file
		if string.sub(arg, 1, 4) == "help" then
			local bosm_help = getBOSMHelp()
			Core.SendToUser(tUser, bosm_help)
		elseif string.sub(arg, 1, 7) == "fixture" then
			local bosm_fixtures = getBOSMFixtures()
			local pm_popup = "<" .. BOT_NAME .. "> Fixtures have been sent to you via PM. Please Check!"
			Core.SendToUser(tUser, pm_popup)
			Core.SendPmToUser(tUser, BOT_NAME, bosm_fixtures)
		elseif string.sub(arg, 1, 6) == "result" then
			local bosm_results = getBOSMResults()
			local pm_popup = "<" .. BOT_NAME .. "> Results have been sent to you via PM. Please Check!"
			Core.SendToUser(tUser, pm_popup)
			Core.SendPmToUser(tUser, BOT_NAME, bosm_results)
		elseif string.sub(arg, 1, 4) == "logo" then
			local bosm_logo = getBOSMLogo()
			local bosm_logo_info = getBOSMLogoInfo()
			local pm_popup = "<" .. BOT_NAME .. "> BOSM - 2013 Logo have been sent to you via PM. Please Check!"
			Core.SendToUser(tUser, pm_popup)
			Core.SendToUser(tUser, bosm_logo_info)
			Core.SendPmToUser(tUser, BOT_NAME, bosm_logo)
		elseif string.sub(arg, 1, 7) == "gallery" then
			local bosm_gallery = getBOSMGallery()
			Core.SendToUser(tUser, bosm_gallery)
		elseif arg == "" then
			local bosm = getBOSM()
			Core.SendToAll(BOSM_YAWP)
			Core.SendToUser(tUser, bosm)
		end
	end

end

-- Function to get BOSM Help Info
function getBOSMHelp()
	local file = io.open(BOSM_HELP_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. " > The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get BOSM Fixtures Info
function getBOSMFixtures()
	local file = io.open(BOSM_FIXTURES_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get BOSM Results Info
function getBOSMResults()
	local file = io.open(BOSM_RESULTS_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get BOSM Logo
function getBOSMLogo()
	local file = io.open(BOSM_LOGO_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get BOSM Logo Info
function getBOSMLogoInfo()
	local file = io.open(BOSM_LOGO_INFO_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. " > The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get BOSM Gallery
function getBOSMGallery()
	local file = io.open(BOSM_GALLERY_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. " > The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get BOSM Main Command Info
function getBOSM()
	local file = io.open(BOSM_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. " > The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end