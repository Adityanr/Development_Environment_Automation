## Parameters
$AppPoolName = 'WMS'
$websiteFolder = 'C:\Development\eManager\WmsWeb'
$websiteName = 'WMS'

## Setup app pool if it doesnt already exist
if (!(Test-Path IIS:\\AppPools\\$AppPoolName)){New-WebAppPool -Name $AppPoolName -Force}
Set-Location IIS:\\AppPools\\
$AppPool = Get-Item .\\$AppPoolName
$AppPoolID = $AppPool.processmodel.userName

## Website setup at port 80
if (!(Test-Path $websiteFolder)){throw "No website folder found"}
if (Get-Website -Name 'Default Web Site') {Remove-Website -Name 'Default Web Site'}
$Website = New-Website -Name $websiteName -Port 80 -PhysicalPath $websiteFolder -ApplicationPool $AppPool.Name -Force
Start-Website -Name $websiteName