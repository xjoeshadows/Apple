-- Function to check if your VPN is connected
on isVPNConnected()
	try
		set vpnStatus to do shell script "scutil --nc status 'VPNConnectionNameHere'" -- Ensure this matches your VPN connection name
		set statusLines to paragraphs of vpnStatus -- Split the output into lines
		if (item 1 of statusLines) = "Connected" then
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
	set appName to "YourAppNameHere" -- Replace with the name of your application
	set appArgs to {"--First Arg", "Second Arg"} -- Replace with your actual arguments
	
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
	set AppleScript's text item delimiters to " "
	repeat with arg in appArgs
		set argString to argString & arg & " "
	end repeat
	set AppleScript's text item delimiters to ""
	
	-- Use the 'open' command to directly execute the app binary with arguments
	do shell script "open -a " & quoted form of appName & " --args " & argString
end openApplication
