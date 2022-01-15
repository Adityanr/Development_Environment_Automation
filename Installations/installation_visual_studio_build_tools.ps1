param(
    ## Installer download location
    [string]$InstallersFolder
)

## Download Visual Studio Enterprise 2019
Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vs_BuildTools.exe" -OutFile "${InstallersFolder}\vs_BuildTools.exe"

## Install Visual Studio Build tools 2019 (Basic)
Start-Process "${InstallersFolder}\vs_BuildTools.exe" -ArgumentList @('--installWhileDownloading', '--norestart', '--passive') -NoNewWindow -Wait

Start-Sleep -s 30

