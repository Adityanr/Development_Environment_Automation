## Install chocolatey
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## Enable global confirmation
&"C:\ProgramData\chocolatey\choco.exe" feature enable -n=allowGlobalConfirmation

## Install git
&"C:\ProgramData\chocolatey\choco.exe" install git

Start-Sleep -s 30