-- Function to check if your VPN is connected
on isVPNConnected()
	try
		set vpnStatus to do shell script "scutil --nc status 'YourVPNNameHere'" -- Ensure this matches your VPN connection name
		if vpnStatus contains "Connected" then
			return true
		else
			return false
		end if
	on error errMsg
		display alert "Error checking VPN status: " & errMsg
		return false
	end try
end isVPNConnected

-- Main handler to run the script
on run
	set appName to "YourApplication" -- Replace with the name of your application
	set appArgs to {"--YourArgument"} -- Replace with your actual arguments
	
	-- Check VPN status
	if isVPNConnected() then
		-- Open the application with arguments
		openApplication(appName, appArgs)
	else
		set userResponse to display dialog "VPN is not connected. Would you like to open " & appName & " anyway?" buttons {"No", "Yes"} default button "No"
		if button returned of userResponse is "Yes" then
			-- Open the application with arguments
			openApplication(appName, appArgs)
		end if
	end if
end run

-- Function to open the application with arguments
on openApplication(appName, appArgs)
	-- Construct the command to open the application with arguments
	set argString to ""
	repeat with arg in appArgs
		set argString to argString & " " & arg
	end repeat
	
	-- Use the 'do shell script' command to directly execute the app's binary with arguments
	do shell script quoted form of "/Applications/YourApp.app/Contents/MacOS/YourAppBinary" & argString
end openApplication
