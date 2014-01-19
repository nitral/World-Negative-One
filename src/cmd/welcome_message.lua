--[[
	
	Welcome Message 1.0 LUA 5.2.1
	
	By XAN		10/09/2013
	Requested By RadioAKTIV
	
	A simple script that displays a welcome message to a newly connected user.
]]

function UserConnected(tUser)
	
	local TOP_BORDER = "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
	
	local logo =   ""
	logo = logo .. "                                                        \n"
	logo = logo .. "                    W                   W                                   1 1   \n "
	logo = logo .. "                    W                 W                                    1 1   \n "
	logo = logo .. "                     W      W      W            =========         1 1   \n " 
	logo = logo .. "                      W  W   W  W                                      1 1   \n "                              
	logo = logo .. "                       W           W                                       1 1   \n "
	
	local MIDDLE_BORDER_1 = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
	
	local hub_message = "                                           WORLD NEGATIVE ONE                [/* SuperMario */]         \n"
	
	local MIDDLE_BORDER_2 = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
	
	local commands =      "                                       COMMANDS AVAILABLE ARE:-\n"
	commands = commands .. "  General Commands: +help, +hublist, +uploads, +notices, +history, +history <no_of_lines>, +mess\n"
	commands = commands .. "                                         Gaming Commands: +cs, +cod , +csgo, +dota \n"
	commands = commands .. "                                              BOSM Commands: +bosm, \n"
	commands = commands .. "                                     RadioAKTIV Commands: +radioaktiv\n"  
	commands = commands .. "                      Comic Commands: +comic, +comic help, +comic about, +comic artists\n"
	
	local BOTTOM_BORDER = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
	
	local welcome_message = TOP_BORDER .. logo .. MIDDLE_BORDER_1 .. hub_message .. MIDDLE_BORDER_2 .. commands .. BOTTOM_BORDER
	
	Core.SendToUser(tUser, welcome_message)
end