## Parameters
param(
    # eManager Folder
    [string]$EManagerFolder
    ## Installer download location
    [string]$InstallersFolder
)

## Restore NuGet packages
cd $EManagerFolder
&"${InstallersFolder}\nuget.exe" restore .\AutoStoreManagementSystem.sln -Verbosity quiet

## Build project
&"C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSbuild.exe" -restore:True -verbosity:quiet -target:Rebuild .\AutoStoreManagementSystem.sln