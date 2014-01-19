--[[
	
	Mess Commands 1.0 LUA 5.2.1
	
	By XAN		14/10/2013
	Requested By XAN
	
	A script that displays the menu of the following meal at BITS messes.
	
	Command:
	+breakfast				- Displays the breakfast menu for the following breakfast meal.
	+lunch					- Displays the lunch menu for the following lunch meal.
	+dinner					- Displays the dinner menu for the following dinner meal.
	+mess					- Displays the mess menu for the following week/fortnight/month.
]]

-- Settings and Global Declarations
BREAKFAST_PATH = ""
LUNCH_PATH = ""
DINNER_PATH = ""
MESS_MENU_PATH = ""
BEAKFAST_THRESHOLD_HOUR = 10
LUNCH_THRESHOLD_HOUR = 14
DINNER_THRESHOLD_HOUR = 21

function OnStartup()

	-- Make Paths --
	BREAKFAST_PATH = ".\\scripts\\mess_files\\breakfast.txt"
	LUNCH_PATH = ".\\scripts\\mess_files\\lunch.txt"
	DINNER_PATH = ".\\scripts\\mess_files\\dinner.txt"
	MESS_MENU_PATH = ".\\scripts\\mess_files\\mess.txt"

end

function ChatArrival(tUser, sData)
	
	local cmd = string.gsub(sData, "%b<> ", ""):sub(1)										-- Get Command Used
	cmd = string.sub(cmd, 1, cmd:len() - 1)
	
	if cmd == "!breakfast" or cmd == "+breakfast" or cmd == "-breakfast" or cmd == "/breakfast" or cmd == "*breakfast" then
		local breakfast_menu = getBreakfastMenu()
		Core.SendToUser(tUser, breakfast_menu)
	elseif cmd == "!lunch" or cmd == "+lunch" or cmd == "-lunch" or cmd == "/lunch" or cmd == "*lunch" then
		local lunch_menu = getLunchMenu()
		Core.SendToUser(tUser, lunch_menu)
	elseif cmd == "!dinner" or cmd == "+dinner" or cmd == "-dinner" or cmd == "/dinner" or cmd == "*dinner" then
		local dinner_menu = getDinnerMenu()
		Core.SendToUser(tUser, dinner_menu)
	elseif cmd == "!mess" or cmd == "+mess" or cmd == "-mess" or cmd == "/mess" or cmd == "*mess" then
		local mess_menu = getMessMenu()
		Core.SendToUser(tUser, mess_menu)
	end
end

-- Function to get Breakfast Menu
function getBreakfastMenu()

	local file = io.open(BREAKFAST_PATH, "r")													-- Open Menu Data File
	if file == nil then
		return "<W-1> The requested file wasn't found. Please inform the SysAdmin."
	else
		local number_of_items = 0
		local breakfast_items = {}
		local contents = file:read("*all")
		
		-- Get Menu and prepare Data Table --
		for breakfast_item in string.gmatch(contents, "[^\n]+") do
			if breakfast_item:gsub(" ", "") ~= "" then
				table.insert(breakfast_items, trim(breakfast_item))
				number_of_items = number_of_items + 1
			end
		end
		
		--== Make Menu from Data Table ==--
		local breakfast_menu = "\n                            --=-= BREAKFAST MENU =-=--\n"
		
		-- Add Timestamp --
		if tonumber(os.date("%H")) >= BEAKFAST_THRESHOLD_HOUR then							-- Check Threshold Time
			breakfast_menu = breakfast_menu .. "                            For: " ..os.date("%A %d/%B/%Y",os.time()+24*60*60) .. "\n"
		else
			breakfast_menu = breakfast_menu .. "                            For: " ..os.date("%A %d/%B/%Y",os.time()) .. "\n"
		end
			breakfast_menu = breakfast_menu .. "                            Menu: " .. breakfast_items[1]
		
		-- Concatenate Menu --
		local counter = 2
		while counter <= number_of_items do
			breakfast_menu = breakfast_menu .. ", " .. breakfast_items[counter]
			counter = counter + 1
		end
		
		return "<W-1> " .. breakfast_menu 													-- Return Menu
	end
end

-- Function to get Lunch Menu
function getLunchMenu()

	local file = io.open(LUNCH_PATH, "r")													-- Open Menu Data File
	if file == nil then
		return "<W-1> The requested file wasn't found. Please inform the SysAdmin."
	else
		local number_of_items = 0
		local lunch_items = {}
		local contents = file:read("*all")
		
		-- Get Menu and prepare Data Table --
		for lunch_item in string.gmatch(contents, "[^\n]+") do
			if lunch_item:gsub(" ", "") ~= "" then
				table.insert(lunch_items, trim(lunch_item))
				number_of_items = number_of_items + 1
			end
		end
		
		--== Make Menu from Data Table ==--
		local lunch_menu = "\n                            --=-= LUNCH MENU =-=--\n"
		
		-- Add Timestamp --
		if tonumber(os.date("%H")) >= LUNCH_THRESHOLD_HOUR then							-- Check Threshold Time
			lunch_menu = lunch_menu .. "                            For: " ..os.date("%A %d/%B/%Y",os.time()+24*60*60) .. "\n"
		else
			lunch_menu = lunch_menu .. "                            For: " ..os.date("%A %d/%B/%Y",os.time()) .. "\n"
		end
			lunch_menu = lunch_menu .. "                            Menu: " .. lunch_items[1]
		
		-- Concatenate Menu --
		local counter = 2
		while counter <= number_of_items do
			lunch_menu = lunch_menu .. ", " .. lunch_items[counter]
			counter = counter + 1
		end
		
		return "<W-1> " .. lunch_menu 													-- Return Menu
	end
end

-- Function to get Dinner Menu
function getDinnerMenu()

	local file = io.open(DINNER_PATH, "r")													-- Open Menu Data File
	if file == nil then
		return "<W-1> The requested file wasn't found. Please inform the SysAdmin."
	else
		local number_of_items = 0
		local dinner_items = {}
		local contents = file:read("*all")
		
		-- Get Menu and prepare Data Table --
		for dinner_item in string.gmatch(contents, "[^\n]+") do
			if dinner_item:gsub(" ", "") ~= "" then
				table.insert(dinner_items, trim(dinner_item))
				number_of_items = number_of_items + 1
			end
		end
		
		--== Make Menu from Data Table ==--
		local dinner_menu = "\n                            --=-= DINNER MENU =-=--\n"
		
		-- Add Timestamp --
		if tonumber(os.date("%H")) >= DINNER_THRESHOLD_HOUR then							-- Check Threshold Time
			dinner_menu = dinner_menu .. "                            For: " ..os.date("%A %d/%B/%Y",os.time()+24*60*60) .. "\n"
		else
			dinner_menu = dinner_menu .. "                            For: " ..os.date("%A %d/%B/%Y",os.time()) .. "\n"
		end
			dinner_menu = dinner_menu .. "                            Menu: " .. dinner_items[1]
		
		-- Concatenate Menu --
		local counter = 2
		while counter <= number_of_items do
			dinner_menu = dinner_menu .. ", " .. dinner_items[counter]
			counter = counter + 1
		end
		
		return "<W-1> " .. dinner_menu 													-- Return Menu
	end
end

function getMessMenu()

	local file = io.open(MESS_MENU_PATH, "r")
	
	if file then
		local contents = file:read("*all")
		return "<W-1> " .. contents
	else
		return "<W-1> The requested file wasn't found. Please inform the SysAdmin."
	end
end

function trim(s)
  local a = s:match('^%s*()')
  local b = s:match('()%s*$', a)
  return s:sub(a,b-1)
end