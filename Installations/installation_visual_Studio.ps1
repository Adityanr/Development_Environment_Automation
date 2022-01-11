## Download Visual Studio Enterprise 2022
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vs_enterprise.exe" -OutFile "C:\Installers\vs_enterprise.exe" -UseBasicParsing

## Install Visual Studio Enterprise 2022 (Basic)
C:\Installers\vs_enterprise.exe --installWhileDownloading --norestart --quiet

Start-Sleep -s 30

