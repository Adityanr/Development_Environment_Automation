param(
    ## Installer download location
    [string]$InstallersFolder
)

## Download Visual Studio Enterprise 2022
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_enterprise.exe" -OutFile "${InstallersFolder}\vs_enterprise.exe" -UseBasicParsing

## Install Visual Studio Enterprise 2022 (Basic)
Start-Process "${InstallersFolder}\vs_enterprise.exe" -ArgumentList @('--installWhileDownloading', '--norestart', '--passive') -NoNewWindow -Wait

Start-Sleep -s 30

