## Ask for required credentials
$Credential = $host.ui.PromptForCredential("Need credentials", "Please enter your user name and password for sql server SA user.", "", "NetBiosUserName")