## Parameters
param(
    # eManager Folder
    [string]$EManagerFolder
)

## Restore NuGet packages
cd $EManagerFolder
C:\Installers\nuget.exe restore .\AutoStoreManagementSystem.sln -Verbosity quiet

## Build project
&"C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSbuild.exe" -restore:True -verbosity:quiet -target:Rebuild .\AutoStoreManagementSystem.sln