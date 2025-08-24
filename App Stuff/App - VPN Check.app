-- Define the application you want to open
set appName to "AppName" -- Replace with the name of your app

-- Function to check if Proton VPN is connected
on isVPNConnected()
	try
		set vpnStatus to do shell script "scutil --nc status 'ProtonVPN'" -- Ensure the name matches exactly
		-- Check for specific lines in the output
		if vpnStatus starts with "Connected" then
			return true
		else
			return false
		end if
	on error errMsg
		log "Error checking VPN status: " & errMsg
		return false
	end try
end isVPNConnected

-- Check VPN status
if isVPNConnected() then
	tell application appName to activate
else
	set userResponse to display dialog "VPN is not connected. Would you like to open " & appName & " anyway?" buttons {"No", "Yes"} default button "No"
	if button returned of userResponse is "Yes" then
		tell application appName to activate
	end if
end if
