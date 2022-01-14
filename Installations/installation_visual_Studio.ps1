## Download Visual Studio Enterprise 2022
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_enterprise.exe" -OutFile "C:\Installers\vs_enterprise.exe" -UseBasicParsing
Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vs_BuildTools.exe" --OutFile "C:\Installers\vs_BuildTools.exe"

## Install Visual Studio Enterprise 2022 (Basic)
Start-Process "C:\Installers\vs_enterprise.exe" -ArgumentList @('--installWhileDownloading', '--norestart', '--passive') -NoNewWindow -Wait

## Install Visual Studio Build tools 2022 (Basic)
Start-Process "C:\Installers\vs_BuildTools.exe" -ArgumentList @('--installWhileDownloading', '--norestart', '--passive') -NoNewWindow -Wait

Start-Sleep -s 30

