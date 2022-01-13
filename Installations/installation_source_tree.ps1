## PS App Deploy tool kit download
Invoke-WebRequest -Uri "https://github.com/PSAppDeployToolkit/PSAppDeployToolkit/releases/download/3.8.4/PSAppDeployToolkit_v3.8.4.zip" -UseBasicParsing -OutFile "C:\Installers\PSAppDeployToolkit.zip"
Unblock-File -Path "C:\Installers\PSAppDeployToolkit.zip"
Expand-Archive -Path "C:\Installers\PSAppDeployToolkit.zip" -DestinationPath "C:\Installers\PADT\" -Force
Copy-Item -Path "C:\Installers\PADT\Toolkit\AppDeployToolkit" -Destination "C:\Installers\SourceTree\AppDeployToolkit" -Recurse -Force
Copy-Item -Path "C:\Installers\PADT\Toolkit\Files" -Destination "C:\Installers\SourceTree\Files" -Force

## Source tree msi download
Invoke-WebRequest -Uri "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_3.4.7.msi" -UseBasicParsing -OutFile "C:\Installers\SourcetreeEnterpriseSetup.msi"
Copy-Item "C:\Installers\SourcetreeEnterpriseSetup.msi" -Destination "C:\Installers\SourceTree\Files\" -Force

## Setup app deploy tool kit
$scriptDirectory = "C:\Installers\SourceTree"
[string]$moduleAppDeployToolkitMain = "$scriptDirectory\AppDeployToolkit\AppDeployToolkitMain.ps1"
If (-not (Test-Path -LiteralPath $moduleAppDeployToolkitMain -PathType 'Leaf')) { Throw "Module does not exist at the specified location [$moduleAppDeployToolkitMain]." }
If ($DisableLogging) { . $moduleAppDeployToolkitMain -DisableLogging } Else { . $moduleAppDeployToolkitMain }

## Install Source tree
$MsiPath = "C:\Installers\SourceTree\Files\SourcetreeEnterpriseSetup.msi"
Execute-MSI -Action Install -Path "$MsiPath" -AddParameters "ACCEPTEULA=1"

Start-Sleep -s 30