## Parameters
param(
    # Website folder
    [string]$WebsiteFolder,
    # App pool name
    [string]$AppPoolName,
    # WebSite name
    [string]$WebsiteName,
    # Port number
    [int]$PortNumber
)

## Setup app pool if it doesnt already exist
if (Test-Path IIS:\\AppPools\\$AppPoolName){Remove-WebAppPool -Name $AppPoolName}
New-WebAppPool -Name $AppPoolName -Force
Set-Location IIS:\\AppPools\\
$AppPool = Get-Item .\\$AppPoolName
$AppPoolID = $AppPool.processmodel.userName

## Website setup
if (!(Test-Path $WebsiteFolder)){throw "No website folder found"}
if (Get-Website -Name $WebsiteName) {Remove-Website -Name $WebsiteName}
$Website = New-Website -Name $WebsiteName -Port $PortNumber -PhysicalPath $WebsiteFolder -ApplicationPool $AppPool.Name -Force
Start-Website -Name $WebsiteName