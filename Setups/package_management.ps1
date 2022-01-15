## Parameters
param(
    # eManager Folder
    [string]$EManagerFolder,
    ## Installer download location
    [string]$InstallersFolder
)

## NuGet add package
cd $EManagerFolder
dotnet nuget add source https://api.nuget.org/v3/index.json --name "nuget.org"
dotnet nuget add source https://elementlogic.myget.org/F/ewms/auth/29344e55-1c43-478c-a00e-137f1d6956ea/api/v3/index.json --name "EWS Package Feed"
dotnet nuget add source https://elementlogic.myget.org/F/shared/auth/a70646f0-dfc4-4cb9-b27f-06bff16b4eba/api/v2 --name "ElementLogic shared"
dotnet nuget add source https://elementlogic.myget.org/F/ams/auth/ead7ab75-2a4a-4664-835b-66ec283de3e0/api/v3/index.json --name "ElementLogic AMS"

## Set dotnet sdk path
$variableNameToAdd = 'PATH'
$path_env_value = $env:PATH
$variableValueToAdd = "${path_env_value};C:\Program Files\dotnet\"
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::User)

## Set proper SDK compatible to the project for cli run
$variableNameToAdd = 'MSBuildSDKsPath'
$variableValueToAdd = (Resolve-Path -Path "C:\Program Files\dotnet\sdk\5.*\Sdks").Path
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::User)

## Setup nuget cli
Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -UseBasicParsing -OutFile "${InstallersFolder}\nuget.exe"