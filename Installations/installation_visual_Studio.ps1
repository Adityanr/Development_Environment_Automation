## Download Visual Studio Enterprise 2022
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_enterprise.exe" -OutFile "C:\Installers\vs_enterprise.exe" -UseBasicParsing

## Install Visual Studio Enterprise 2022 (Basic)
Start-Process "C:\Installers\vs_enterprise.exe" -ArgumentList @('--installWhileDownloading', '--norestart', '--passive') -NoNewWindow -Wait

Start-Sleep -s 30

