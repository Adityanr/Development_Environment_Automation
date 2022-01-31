param(
    ## Installer download location
    [string]$InstallersFolder
)

## Download Visual Studio Build tools
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vs_BuildTools.exe" -OutFile "${InstallersFolder}\vs_BuildTools.exe"

## Install Visual Studio Build tools (Basic)
Start-Process "${InstallersFolder}\vs_BuildTools.exe" -ArgumentList @('--installWhileDownloading', '--norestart', '--passive') -NoNewWindow -Wait

Start-Sleep -s 30

