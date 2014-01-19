--[[
	Series Bot 1.0 LUA 5.2.1

	By XAN		10/10/2013
	Requested By XAN

	A script that retieves information about latest Tv Series asked by the user.
	API Used: TvRage

	Command:
	+next <series_name>				- Displays the next episode of the series.
	+last <series_name>				- Displays the latest episode of the series.
	+series <series_name>			- Displays next and latest episode information along with some series information.
]]

-- Settings and Global Declarations
SERIES_INFO_TMP = "..\\tmp\\series_tmp.txt"
SERIES_INFO_DOWNLOAD = ".\\series-bot_download.ps1"

-- TvRage API Vars
TVRAGE_BASE_URL = "http://services.tvrage.com/tools/quickinfo.php?show="

-- Bot Settings
BOT_NAME = "[Series-BOT]"
BOT_DESC = "Series Updates and Info."
BOT_EMAIL = ""
BOT_HAVE_KEY = true

function OnStartup()

	-- Register Series Bot --
	Core.RegBot(BOT_NAME, BOT_DESC, BOT_EMAIL, BOT_HAVE_KEY)
	
end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 5)												-- Strip Command from Chat Data
	local arg = string.gsub(sData, "%b<> ", ""):sub(7)													-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1)
	
	if cmd == "!next" or cmd == "+next" or cmd == "-next" or cmd == "/next" or cmd == "*next" then		-- Confirm Command
		local next_episode_info = getNextEpisodeInfo(arg)
		if next_episode_info then
			local next_episode_info_message = "<" .. BOT_NAME .. "> " .. next_episode_info
			Core.SendToAll(next_episode_info_message)
		else
			next_episode_info = "Specified Series Information could not be retrieved. Please try again or contact the SysAdmin."
			local next_episode_info_message = "<" .. BOT_NAME .. "> " .. next_episode_info
			Core.SendToUser(tUser, next_episode_info_message)
		end
		return false
	end
	
	if cmd == "!last" or cmd == "+last" or cmd == "-last" or cmd == "/last" or cmd == "*last" then		-- Confirm Command
		local last_episode_info = getLastEpisodeInfo(arg)
		if last_episode_info then
			local last_episode_info_message = "<" .. BOT_NAME .. "> " .. last_episode_info
			Core.SendToAll(last_episode_info_message)
		else
			last_episode_info = "Specified Series Information could not be retrieved. Please try again or contact the SysAdmin."
			local last_episode_info_message = "<" .. BOT_NAME .. "> " .. last_episode_info
			Core.SendToUser(tUser, last_episode_info_message)
		end
		return false
	end
	
	cmd = string.gsub(sData, "%b<> ", ""):sub(1, 7)												-- Strip Command from Chat Data
	arg = string.gsub(sData, "%b<> ", ""):sub(9)													-- Strip maximum possible argument length from Chat Data
	
	-- PREPARE ARG --
	arg = string.sub(arg, 1, arg:len() - 1)
	
	if cmd == "!series" or cmd == "+series" or cmd == "-series" or cmd == "/series" or cmd == "*series" then		-- Confirm Command
		local series_info = getSeriesInfo(arg)
		local series_info_message = "<" .. BOT_NAME .. "> " .. series_info
		Core.SendToUser(tUser, series_info_message)
		return false
	end
	
end

-- Function to Retreive Next Episode Information
function getNextEpisodeInfo(series)

	series = series:gsub(" ", "+")
	
	local series_info = fetchSeries(series)
	
	local info_table = parseSeries(series_info)
	
	if not info_table["Show Name"] then
		return nil
	else
		local series_next_info = ""
		series_next_info = series_next_info .. "Series Name: " .. info_table["Show Name"]
		if info_table["Next Season"] then
			series_next_info = series_next_info .. "   l   Season: " .. info_table["Next Season"]
			series_next_info = series_next_info .. "   l   Episode: " .. info_table["Next Episode Number"] .. "  " .. info_table["Next Episode Name"]
			series_next_info = series_next_info .. "   l   Date: " .. info_table["Next Episode Date"]
		elseif info_table["Latest Season"] then
			series_next_info = series_next_info .. "   l   Season: " .. info_table["Latest Season"]
			series_next_info = series_next_info .. "   l   Episode: " .. info_table["Latest Episode Number"] .. "  " .. info_table["Latest Episode Name"]
			series_next_info = series_next_info .. "   l   Date: " .. info_table["Latest Episode Date"]
		elseif info_table["Ended"] then
			series_next_info = series_next_info .. "   l   Ended: " .. info_table["Ended"]
		end
		return series_next_info
	end

end

-- Function to Retreive Latest Episode Information
function getLastEpisodeInfo(series)

	series = series:gsub(" ", "+")
	
	local series_info = fetchSeries(series)
	
	local info_table = parseSeries(series_info)
	
	if not info_table["Show Name"] then
		return nil
	else
		local series_latest_info = ""
		series_latest_info = series_latest_info .. "Series Name: " .. info_table["Show Name"]
		if info_table["Latest Season"] then
			series_latest_info = series_latest_info .. "   l   Season: " .. info_table["Latest Season"]
			series_latest_info = series_latest_info .. "   l   Episode: " .. info_table["Latest Episode Number"] .. "  " .. info_table["Latest Episode Name"]
			series_latest_info = series_latest_info .. "   l   Date: " .. info_table["Latest Episode Date"]
		elseif info_table["Next Season"] then
			series_latest_info = series_latest_info .. "   l   Season: " .. info_table["Next Season"]
			series_latest_info = series_latest_info .. "   l   Episode: " .. info_table["Next Episode Number"] .. "  " .. info_table["Next Episode Name"]
			series_latest_info = series_latest_info .. "   l   Date: " .. info_table["Next Episode Date"]
		elseif info_table["Ended"] then
			series_latest_info = series_latest_info .. "   l   Ended: " .. info_table["Ended"]
		end
		return series_latest_info
	end

end

-- Function to Retreive Complete Series Information
function getSeriesInfo(series)

	series = series:gsub(" ", "+")
	
	local series_info = fetchSeries(series)
	
	local info_table = parseSeries(series_info)
	
	if not info_table["Show Name"] then
		return "Specified Series Information could not be retrieved. Please try again or contact the SysAdmin."
	else
		local series_complete_info = "\r\n"
		-- Make Complete Info --
		series_complete_info = series_complete_info .. "Series Name: " .. info_table["Show Name"] .. "\r\n"
		series_complete_info = series_complete_info .. "Started: " .. info_table["Started"] .. "\t\t\t\t" .. "Ended: "
		if info_table["Ended"] == "" then
			series_complete_info = series_complete_info .. "Ongoing\r\n"
		else
			series_complete_info = series_complete_info .. info_table["Ended"] .. "\r\n"
		end
		if info_table["Latest Episode"] then
			series_complete_info = series_complete_info .. "Last Episode  - Season: " .. info_table["Latest Season"] .. "  l  Episode: " .. info_table["Latest Episode Number"] .. "  " .. info_table["Latest Episode Name"] .. "  l  Date: " .. info_table["Latest Episode Date"] .. "\r\n"
		end
		if info_table["Next Episode"] then
			series_complete_info = series_complete_info .. "Next Episode - Season: " .. info_table["Next Season"] .. "  l  Episode: " .. info_table["Next Episode Number"] .. "  " .. info_table["Next Episode Name"] .. "  l  Date: " .. info_table["Next Episode Date"] .. "\r\n"
		end
		series_complete_info = series_complete_info .. "Country: " .. info_table["Country"] .. "\r\n"
		series_complete_info = series_complete_info .. "Genres: " .. info_table["Genres"]:gsub("|", "l") .. "\r\n"
		series_complete_info = series_complete_info .. "Episode Duration: " .. info_table["Runtime"] .. " minutes"
	
		return series_complete_info
	end

end

function fetchSeries(series)
	local path_change_command = "cd ..\\bin\\"
	local download_command = "start /min Powershell " .. SERIES_INFO_DOWNLOAD .. " " .. TVRAGE_BASE_URL .. series .. " " .. SERIES_INFO_TMP
	
	local download = io.popen(path_change_command .. " && " .. download_command):read("*all")
	
	local file = io.open(SERIES_INFO_TMP, "r")
	local contents = ""
	if file == nil then
		return nil
	else
		contents = file:read("*all")
		return contents
	end
end

function parseSeries(series_info)
	
	-- Parse Information to get +next info --
	local info_table = {}
	
	-- Split into lines
	for record in string.gmatch(series_info, "[^\n]+") do
		local fieldType = 0
		local fieldName = ""
		local fieldValue = ""
		for field in string.gmatch(record, "[^@]+") do
			if fieldType == 0 then
				fieldName = field
			else
				fieldValue = field
			end
			fieldType = fieldType + 1
		end
		info_table[fieldName] = fieldValue
	end
	
	-- Parse Latest Episode Information --
	if info_table["Latest Episode"] then
		local latestEpisodeFieldType = 0
		for latestEpisodeFieldValue in string.gmatch(info_table["Latest Episode"], "[^^]+") do
			if latestEpisodeFieldType == 0 then
				info_table["Latest Season"] = latestEpisodeFieldValue:sub(1, 2)
				info_table["Latest Episode Number"] = latestEpisodeFieldValue:sub(4, 5)
			elseif latestEpisodeFieldType == 1 then
				info_table["Latest Episode Name"] = latestEpisodeFieldValue:sub(1)
			else
				info_table["Latest Episode Date"] = latestEpisodeFieldValue:sub(1)
				info_table["Latest Episode Month"] = latestEpisodeFieldValue:sub(1, 3)
				info_table["Latest Episode Day"] = latestEpisodeFieldValue:sub(5, 6)
				info_table["Latest Episode Year"] = latestEpisodeFieldValue:sub(8)
			end
			latestEpisodeFieldType = latestEpisodeFieldType + 1
		end
	end
	
	-- Parse Next Episode Information --
	if info_table["Next Episode"] then
		local nextEpisodeFieldType = 0
		for nextEpisodeFieldValue in string.gmatch(info_table["Next Episode"], "[^^]+") do
			if nextEpisodeFieldType == 0 then
				info_table["Next Season"] = nextEpisodeFieldValue:sub(1, 2)
				info_table["Next Episode Number"] = nextEpisodeFieldValue:sub(4, 5)
			elseif nextEpisodeFieldType == 1 then
				info_table["Next Episode Name"] = nextEpisodeFieldValue:sub(1)
			else
				info_table["Next Episode Date"] = nextEpisodeFieldValue:sub(1)
				info_table["Next Episode Month"] = nextEpisodeFieldValue:sub(1, 3)
				info_table["Next Episode Day"] = nextEpisodeFieldValue:sub(5, 6)
				info_table["Next Episode Year"] = nextEpisodeFieldValue:sub(8)
			end
			nextEpisodeFieldType = nextEpisodeFieldType + 1
		end
	end
	
	return info_table
end