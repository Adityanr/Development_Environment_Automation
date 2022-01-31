## Parameters
param(
    # eManager Folder
    [string]$EManagerFolder,
    ## Installer download location
    [string]$InstallersFolder
)

## Restore NuGet packages
Set-Location $EManagerFolder
&"${InstallersFolder}\nuget.exe" restore .\AutoStoreManagementSystem.sln -Verbosity quiet

## Build project
$msbuild_path = (resolve-path "C:\Program Files (x86)\Microsoft Visual Studio\*\BuildTools\MSBuild\Current\Bin\MSbuild.exe").Path
&"${msbuild_path}" -restore:True -verbosity:quiet -target:Rebuild .\AutoStoreManagementSystem.sln