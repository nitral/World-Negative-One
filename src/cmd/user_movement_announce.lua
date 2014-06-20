--[[

	User Movement Announcer 1.0 LUA 5.2.1

	By XAN			16/06/2014
	Requested By XAN

	A simple Lua script that announces when a user enters or exits the chat room using Topcoder style Entry/Exit messages.
]]

-- Settings and Global Declarations
HUB_BOT_NAME = "<[W-1]>"
ENTRY_SUFFIX = "has entered the room."
EXIT_SUFFIX = "has left the room."

function UserConnected(tUser)

	local entry_message = HUB_BOT_NAME .. " " .. tUser.sNick .. " " .. ENTRY_SUFFIX
	Core.SendToAll(entry_message)

end

function UserDisconnected(tUser)

	local exit_message = HUB_BOT_NAME .. " " .. tUser.sNick .. " " .. EXIT_SUFFIX
	Core.SendToAll(exit_message)

end
