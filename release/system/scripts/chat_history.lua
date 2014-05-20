--[[
	
	Chat History 1.0 LUA 5.2.1
	
	By XAN		07/09/2013
	Requested By Nephilim
	
	A Lua Script that logs main chat history and displays it when user requests. Also, it displays a small chat history on user connect.
	
	- Used Dequeue Data Structure
	- Chat History maintained at runtime.
	
	Command:
	+history					- Displays last few main chat history.
	+history <number_of_lines>	- Displays requested amount of main chat history.
]]

-- Settings and Global Declarations
DEFAULT_HISTORY_LENGTH = 15
CONNECT_HISTORY_LENGTH = 15
HISTORIAN_TRIGGER_MESSAGE = "Showing Main Chat History"

-- Bot Settings
BOT_NAME = "[Historian]"
BOT_DESC = "I study and document history."
BOT_EMAIL = ""
BOT_HAVE_KEY = true

-- History Dequeue
history = {}
HISTORY_LENGTH = nil
MAX_HISTORY_LENGTH = 150

function OnStartup()

	-- Register Historian Bot
	Core.RegBot(BOT_NAME, BOT_DESC, BOT_EMAIL, BOT_HAVE_KEY)
	
	HISTORY_LENGTH = 0
end

function UserConnected(tUser)
	local chat_history = getChatHistory(CONNECT_HISTORY_LENGTH)
	local history_message = "<" .. BOT_NAME .. "> " .. HISTORIAN_TRIGGER_MESSAGE .. " [ " .. CONNECT_HISTORY_LENGTH .. " messages] :-\r\n" .. chat_history
	Core.SendToUser(tUser, history_message)
end

function ChatArrival(tUser, sData)

	
	-- Analyze incoming chat for commands and do action accordingly. | Don't save command messages.
	local chat_message_prefix = string.gsub(sData, "%b<> ", ""):sub(1, 1)
	if chat_message_prefix ~= "!" and chat_message_prefix ~= "+" and chat_message_prefix ~= "-" and chat_message_prefix ~= "/" and chat_message_prefix ~= "*" then
		recordChatHistory(sData)
	else
		local cmd = string.gsub(sData, "%b<> ", ""):sub(1, 8)									-- Strip Command from Chat Data
		local arg = string.gsub(sData, "%b<> ", ""):match("%d+")								-- Strip number of lines requested
		
		if cmd == "!history" or cmd == "+history" or cmd == "-history" or cmd == "/history" or cmd == "*history" then	-- Confirm Command
			if arg == nil then
				local chat_history = getChatHistory(DEFAULT_HISTORY_LENGTH)
				local history_message = "<" .. BOT_NAME .. "> " .. HISTORIAN_TRIGGER_MESSAGE .. " [" .. DEFAULT_HISTORY_LENGTH .. " messages] :-\r\n" .. chat_history
				Core.SendToUser(tUser, history_message)
			else
				local chat_history = getChatHistory(arg)
				local history_message = "<" .. BOT_NAME .. "> " .. HISTORIAN_TRIGGER_MESSAGE .. " [" .. arg .. " messages] :-\r\n" .. chat_history
				Core.SendToUser(tUser, history_message)
			end
		end
	end
end

--[[
function getChatHistory(number_of_messages)

	if number_of_messages <= 0 or number_of_messages > MAX_HISTORY_LENGTH then
		return "Invalid argument passed. History is maintained of last " .. MAX_HISTORY_LINES .. " lines. Please contact the SysAdmin for further query."
	elseif number_of_messages > HISTORY_LENGTH then
		return "Not enough history has been recorded yet to fulfill your request."
	end
	
	local chat_history = ""
	local history_start_point = nil
	
	if HISTORY_DEQUEUE_REAR - number_of_messages + 1 > 0 then
		history_start_point = HISTORY_DEQUEUE_REAR - number_of_messages + 1
	else
		history_start_point = MAX_HISTORY_LENGTH - (HISTORY_DEQUEUE_REAR - number_of_messages + 1)
	end
	
	for i = history_start_point, HISTORY_DEQUEUE_REAR, 0 do
		chat_history = chat_history .. history[i]
		
		-- Update i
		if i == MAX_HISTORY_LENGTH then
			i = 1
		else
			i = i + 1
		end
	end
	
	return chat_history
end
]]
--[[
function recordChatHistory(chat_message)
	
	local timestamp = os.date("[%m/%d/%y %I:%M %p] ")
	
	local record = timestamp .. chat_message
	
	if HISTORY_DEQUEUE_REAR == MAX_HISTORY_LENGTH then
		HISTORY_DEQUEUE_REAR = 1
	else
		HISTORY_DEQUEUE_REAR = HISTORY_DEQUEUE_REAR + 1
	end
	
	if HISTORY_DEQUEUE_FRONT == HISTORY_DEQUEUE_REAR then
		HISTORY_DEQUEUE_FRONT = HISTORY_DEQUEUE_FRONT + 1
	end
	
	table.insert(history, 
	
	if HISTORY_LENGTH < MAX_HISTORY_LENGTH then
		HISTORY_LENGTH = HISTORY_LENGTH + 1
	end
end
]]

function recordChatHistory(chat_message)

	local timestamp = os.date("[%I:%M:%S %p] ")
	chat_message = string.sub(chat_message, 1, chat_message:len() - 1) .. "\r\n"
	
	local record = timestamp .. chat_message
	
	table.insert(history, record)
	
	if HISTORY_LENGTH < MAX_HISTORY_LENGTH then
		HISTORY_LENGTH = HISTORY_LENGTH + 1
	else
		table.remove(history, 1)
	end
end

function getChatHistory(s_number_of_messages)

	local number_of_messages = tonumber(s_number_of_messages)
	
	if number_of_messages <= 0 or number_of_messages > MAX_HISTORY_LENGTH then
		return "Invalid argument passed. History is maintained of last " .. MAX_HISTORY_LENGTH .. " lines. Please contact the SysAdmin for further query."
	elseif number_of_messages > HISTORY_LENGTH then
		return "Not enough history has been recorded yet to fulfill your request."
	end
	
	local start_position = HISTORY_LENGTH - number_of_messages + 1
	local chat_history = ""

	for i = start_position, HISTORY_LENGTH do
		chat_history = chat_history .. history[i]
	end
	
	return chat_history
end