## Parameters
param(
    # eManager Folder
    [string]$EManagerFolder
)

## Restore NuGet packages
cd $EManagerFolder
dotnet restore .\AutoStoreManagementSystem.sln

## Build project
&"C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSbuild.exe" -target:Rebuild .\AutoStoreManagementSystem.sln