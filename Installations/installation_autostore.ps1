param(
    # Autostore interface emulator location
    [string]$AutostoreInterfaceEmulatorExeLocation,
    # Autostore http interface location
    [string]$AutostoreHttpInterfaceExeLocation
)

## Autostore emulator installation
Copy-Item $AutostoreInterfaceEmulatorExeLocation -Destination "C:\Installers\AutoStore Interface Emulator_v1.1.9.exe"
&"C:\Installers\AutoStore Interface Emulator_v1.1.9.exe" /NORESTART /VERYSILENT

## Autostore http interface installation
Copy-Item $AutostoreHttpInterfaceExeLocation -Destination "C:\Installers\ASInterfaceHttp_v1.5.15.exe"
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASP -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -All
C:\Installers\ASInterfaceHttp_v1.5.15.exe  /NORESTART /VERYSILENT

Start-Sleep -s 30