param(
    # Autostore http interface location
    [string]$AutostoreHttpInterfaceExeLocation
    ## Installer download location
    [string]$InstallersFolder
)

Start-Sleep -s 30

## Autostore http interface installation
Copy-Item $AutostoreHttpInterfaceExeLocation -Destination "${InstallersFolder}\ASInterfaceHttp_v1.5.15.exe"
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASP -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -All
Start-Process "${InstallersFolder}\ASInterfaceHttp_v1.5.15.exe" -ArgumentList @('/NORESTART', '/SILENT') -NoNewWindow -Wait

Start-Sleep -s 30