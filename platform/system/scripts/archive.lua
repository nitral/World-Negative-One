--[[
	
	Archive BOT 1.0 LUA 5.2.1
	
	By XAN		09/10/2013
	Requested By XAN
	
	A script that serves as a means to archive sections that have temporarily expired or hold relevance to archive contents.
	
	Command:
	+archive					- Displays a list of archived sections and details regarding each.
	+archive help				- Displays a help section related to the Archive Bot.
	+<section_name>				- Same as +archive <section_name>.
]]

-- Settings and Global Declarations
ARCHIVE_PATH = ""
ARCHIVE_HELP_PATH = ""
ARCHIVE_SECTIONS_LIST = ""
ARCHIVE_SECTIONS_ROOT_PATH = ""

-- Archived Sections List
archive = {}
ARCHIVE_SECTION_COUNT = 0

-- Bot Settings
BOT_NAME = "[Archive-BOT]"
BOT_DESC = "I keep the ashes alive."
BOT_EMAIL = ""
BOT_HAVE_KEY = true

function OnStartup()

	-- Make Paths --
	ARCHIVE_PATH = ".\\scripts\\archive_files\\archive.txt"
	ARCHIVE_HELP_PATH = ".\\scripts\\archive_files\\archive_help.txt"
	ARCHIVE_SECTIONS_LIST = ".\\scripts\\archive_files\\archive_sections.txt"
	ARCHIVE_SECTIONS_ROOT_PATH = ".\\scripts\\archive_files\\"

	-- Register Archive Bot --
	Core.RegBot(BOT_NAME, BOT_DESC, BOT_EMAIL, BOT_HAVE_KEY)
	
	-- Load Table of Archived Sections --
	local file = io.open(ARCHIVE_SECTIONS_LIST, "r")
	if file then
		local section = file:read("*line")
		while section do
			table.insert(archive, section)
			ARCHIVE_SECTION_COUNT = ARCHIVE_SECTION_COUNT + 1
			section = file:read("*line")
		end
	else
		Core.SendToAll("The requested file wasn't found. Please inform the SysAdmin.")
	end

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 8)									-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(10)										-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1)
	
	if cmd == "!archive" or cmd == "+archive" or cmd == "-archive" or cmd == "/archive" or cmd == "*archive" then		-- Confirm Command
		-- Lookup Argument passed and get content from corresponding file
		if string.sub(arg, 1, 4) == "help" then
			local archive_help = getArchiveHelp()
			Core.SendToUser(tUser, archive_help)
		elseif arg == "" then
			local archive = getArchive()
			Core.SendToUser(tUser, archive)
		end
	else
		local section = string.gsub(sData, "%b<> ", ""):sub(2)
		section = section:sub(1, section:len() - 1)
		local i = 1
		while i <= ARCHIVE_SECTION_COUNT do
			if archive[i] == section then
				local archive_section = getArchiveSection(section)
				local archive_message = "<" .. BOT_NAME .. "> " .. archive_section
				Core.SendToUser(tUser, archive_message)
				break
			end
			i = i + 1
		end
	end
end

-- Function to get Archive Info
function getArchive()
	local file = io.open(ARCHIVE_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get Archive Help Info
function getArchiveHelp()
	local file = io.open(ARCHIVE_HELP_PATH, "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return "<" .. BOT_NAME .. "> " .. contents
	end
end

-- Function to get Arhive Section Contents
function getArchiveSection(section)
	local file = io.open(ARCHIVE_SECTIONS_ROOT_PATH .. section .. ".txt", "r")
	if file == nil then
		return "<" .. BOT_NAME .. "> The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end