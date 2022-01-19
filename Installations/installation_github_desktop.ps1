param(
    ## Installer download location
    [string]$InstallersFolder
)

## Download Github desktop
if (!(Test-Path -Path "${InstallersFolder}\github_desktop_setup.exe")) {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-WebRequest -Uri "https://central.github.com/deployments/desktop/desktop/latest/win32" -UseBasicParsing -OutFile "${InstallersFolder}\github_desktop_setup.exe"
}

## Install Github desktop
Start-Process "${InstallersFolder}\github_desktop_setup.exe" -ArgumentList @('-s') -NoNewWindow -Wait

Start-Sleep -s 30

$variableNameToAdd = 'PATH'
$path_env_value = $env:PATH
$local_app_data = $env:LOCALAPPDATA
$variableValueToAdd = "${path_env_value};${local_app_data}\GitHubDesktop\app-2.9.6\resources\app\git\mingw64\bin"
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::User)