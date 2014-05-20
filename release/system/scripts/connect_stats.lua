--[[
	
	Connect Statistics 1.0 LUA 5.2.1
	
	By XAN		10/09/2013
	Requested By Nephilim
	
	A simple script that shows some statistics related to the user and the hub.	
]]

function UserConnected(tUser)
	
	-- ---------- HUB INFORMATION ---------- --
	local hub_peak_users = Core.GetActualUsersPeak()
	local hub_share = format_share_size(Core.GetCurrentSharedSize())
	local hub_user_count = Core.GetUsersCount()
	local hub_uptime = convert_time(os.time() - Core.GetUpTime())
	
	-- ---------- USER INFORMATION ---------- --
	Core.GetUserAllData(tUser)
	local user_nick = tUser.sNick
	local user_ip_address = tUser.sIP
	local user_share = format_share_size(tUser.iShareSize) or 0
	local user_desc = tUser.sDescription
	local user_email = tUser.sEmail
	local user_is_active = tUser.bActive
	
	-- ---------- Message to be Displayed on Connection ---------- --
	local header = "\r\n"
	local sub_header = ""
	local hub_info_header = "              ===----~~~~~ HUB INFO ~~~~~----=== \r\n"
	local hub_info = "                  PEAK USERS     :   " .. hub_peak_users .. "\r\n                  HUB SHARE      :   " .. hub_share .. "\r\n                  USER COUNT    :   " .. hub_user_count .. "\r\n                  UPTIME             :   " .. hub_uptime .. "\r\n"
	local hub_info_footer = "                  >>>>>>>>>>>>>><<<<<<<<<<<<<\r\n"
	local user_info_header = "             ===-----~~~~~USER INFO~~~~~------=== \r\n"
	local user_info = "             YOUR NICK             :  " .. user_nick .. "\r\n             YOUR IP ADDRESS :  " .. user_ip_address .. "\r\n             YOUR SHARE         :  " .. user_share .. "\r\n"
	if not user_is_active then
		user_info = user_info .. "\n   You are a Passive User. Please make your Connection \"Direct\" to unleash the full power of DC!\r\n"
	end
	local user_info_footer = "                   >o>o>o>o>o>o>o<o<o<o<o<o<o<\r\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
	local footer = ""
	
	-- ---------- Compile Connection Statistics Message ---------- --
	local connect_stats_message = header .. sub_header .. hub_info_header .. hub_info .. hub_info_footer .. user_info_header .. user_info .. user_info_footer .. footer
	
	-- ---------- Send Message to user ---------- --
	Core.SendToUser(tUser, connect_stats_message)
end


-- ---------- AUXILLARY FUNCTIONS ---------- --
function convert_time(time)
	if time then
		local s,x,n = "",0,os.time()
		local tab = {{31556926,"year"},{2592000,"month"},{604800,"week"},
		{86400,"day"},{3600,"hour"},{60,"minute"},{1,"second"}}
		if time > 0 then
			if time < 2145876659 then
				if n > time then
					time = n - time
				elseif n < time then
					time = time - n
				end
				for i,v in ipairs(tab) do
					if time > v[1] then
						x = math.floor(time/v[1])
						if x > 1 then v[2] = v[2].."s" end
						if x > 0 then
							s = s..x.." "..v[2]..", "
							time = time-x*v[1]
						end
					end
				end
				collectgarbage("collect")
				return s:sub(1,-3)
			else
				return "Invalid date or time supplied. [must be pre 12/31/2037]"
			end
		else
			return "Invalid date or time supplied. [must be post 01/01/1970]"
		end
	else
		return "Invalid date or time supplied."
	end
end

function format_share_size(int)
	local i,u,x = tonumber(int) or 0,{"","K","M","G","T","P"},1
	while i > 1024 do i,x = i/1024,x+1 end return string.format("%.2f %sB",i,u[x])
end