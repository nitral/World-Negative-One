--[[
	
	Comic 1.0 LUA 5.2.1
	
	By XAN		06/09/2013
	Requested By Nephilim
	
	A simple script that produces the latest comic link to a user.
	
	Command:
	+comic			- Displays the comic.
	+comic about		- Gives information about this script.
	+comic artists	- Gives information about the authors.
	+comic help		- Shows the comic help text.
	
]]

-- Settings and Global Declarations
COMIC_PATH = ""
COMIC_HELP_PATH = ""
COMIC_ABOUT_PATH = ""
COMIC_ARTISTS_PATH = ""

function OnStartup()

	COMIC_PATH = ".\\scripts\\comic_files\\comic.txt"
	COMIC_ABOUT_PATH = ".\\scripts\\comic_files\\comic_about.txt"
	COMIC_ARTISTS_PATH = ".\\scripts\\comic_files\\comic_artists.txt"
	COMIC_HELP_PATH = ".\\scripts\\comic_files\\comic_help.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 6)									-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(8, 14)									-- Strip maximum possible argument length from Chat Data
	
	if cmd == "!comic" or cmd == "+comic" or cmd == "-comic" or cmd == "/comic" or cmd == "*comic" then		-- Confirm Command
	
		-- Lookup Argument passed and get content from corresponding file
		if string.sub(arg, 1, 5) == "about" then
			local comic_about = getComicAbout()
			Core.SendToUser(tUser, comic_about)
		elseif string.sub(arg, 1, 7) == "artists" then
			local comic_artists = getComicArtists()
			Core.SendToUser(tUser, comic_artists)
		elseif string.sub(arg, 1, 4) == "help" then
			local comic_help = getComicHelp()
			Core.SendToUser(tUser, comic_help)
		else
			local comic = getComic()
			Core.SendToUser(tUser, comic)
		end
		
	end

end

-- Function to get About Section Content
function getComicAbout()
	local file = io.open(COMIC_ABOUT_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get Artists Section Content
function getComicArtists()
	local file = io.open(COMIC_ARTISTS_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get Help Section Content
function getComicHelp()
	local file = io.open(COMIC_HELP_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end

-- Function to get Comic Strip Content
function getComic()
	local file = io.open(COMIC_PATH, "r")
	if file == nil then
		return "The requested file wasn't found. Please inform the SysAdmin."
	else
		local contents = file:read("*all")
		return contents
	end
end