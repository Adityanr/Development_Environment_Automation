param(
    ## Installer download location
    [string]$InstallersFolder
)

## PS App Deploy tool kit download
Invoke-WebRequest -Uri "https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/download/3.8.4/PSAppDeployToolkit_v3.8.4.zip" -UseBasicParsing -OutFile "${InstallersFolder}\PSAppDeployToolkit.zip"
Unblock-File -Path "${InstallersFolder}\PSAppDeployToolkit.zip"
Expand-Archive -Path "${InstallersFolder}\PSAppDeployToolkit.zip" -DestinationPath "${InstallersFolder}\PADT\" -Force
Copy-Item -Path "${InstallersFolder}\PADT\Toolkit\AppDeployToolkit" -Destination "${InstallersFolder}\SourceTree\AppDeployToolkit" -Recurse -Force
Copy-Item -Path "${InstallersFolder}\PADT\Toolkit\Files" -Destination "${InstallersFolder}\SourceTree\Files" -Force

## Source tree msi download
Invoke-WebRequest -Uri "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.4.7.msi" -UseBasicParsing -OutFile "${InstallersFolder}\SourcetreeEnterpriseSetup.msi"
Copy-Item "${InstallersFolder}\SourcetreeEnterpriseSetup.msi" -Destination "${InstallersFolder}\SourceTree\Files\" -Force

## Setup app deploy tool kit
$scriptDirectory = "${InstallersFolder}\SourceTree"
[string]$moduleAppDeployToolkitMain = "$scriptDirectory\AppDeployToolkit\AppDeployToolkitMain.ps1"
If (-not (Test-Path -LiteralPath $moduleAppDeployToolkitMain -PathType 'Leaf')) { Throw "Module does not exist at the specified location [$moduleAppDeployToolkitMain]." }
If ($DisableLogging) { . $moduleAppDeployToolkitMain -DisableLogging } Else { . $moduleAppDeployToolkitMain }

## Install Source tree
$MsiPath = "${InstallersFolder}\SourceTree\Files\SourcetreeEnterpriseSetup.msi"
Execute-MSI -Action Install -Path "$MsiPath" -AddParameters "ACCEPTEULA=1"

Start-Sleep -s 30