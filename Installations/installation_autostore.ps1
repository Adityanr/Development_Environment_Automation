## Autostore emulator installation
& 'C:\Installers\AutoStore Interface Emulator_v1.1.9.exe' /NORESTART /VERYSILENT

## Autostore http interface installation
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASP -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -All
C:\Installers\ASInterfaceHttp_v1.5.15.exe  /NORESTART /VERYSILENT