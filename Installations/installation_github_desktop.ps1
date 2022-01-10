## Download Github desktop
Invoke-WebRequest -Uri "https://central.github.com/deployments/desktop/desktop/latest/win32" -UseBasicParsing -OutFile "C:\Installers\github_desktop_setup.exe"

## Install Github desktop
C:\Installers\github_desktop_setup.exe -s
