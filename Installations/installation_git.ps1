## Install chocolatey
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## Enable global confirmation
choco feature enable -n=allowGlobalConfirmation

## Install git
choco install git

Start-Sleep -s 30