## Setting up visual studio components for site
C:\Installers\vs_enterprise.exe --wait --noUpdateInstaller --add Microsoft.VisualStudio.Workload.NetWeb --includeRecommended --includeOptional --quiet --norestart
C:\Installers\vs_enterprise.exe --wait --noUpdateInstaller --add Microsoft.VisualStudio.Workload.ManagedDesktop --includeRecommended --includeOptional --quiet --norestart
Start-Sleep -s 900
if (Test-Path -Path 'HKLM:\\SOFTWARE\\WOW6432Node\\Microsoft\\VisualStudio\\Setup\\Reboot') {
    Get-item -Path 'HKLM:\\SOFTWARE\\WOW6432Node\\Microsoft\\VisualStudio\\Setup\\Reboot' | Remove-Item -Force -Verbose
}

## Enabling IIS features
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45 -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CGI -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter -All
Import-Module webadministration

## Alter SQL Authentication mode
$domain = $env:USERDOMAIN
$sql = [Microsoft.SqlServer.Management.Smo.Server]::new("$domain")
$sql.Settings.LoginMode = [Microsoft.SqlServer.Management.SMO.ServerLoginMode]::Mixed
$sql.Alter()

$query = @'
ALTER LOGIN [sa] WITH PASSWORD='Qwe123!@#', CHECK_POLICY=OFF
GO
ALTER LOGIN [sa] ENABLE
GO
'@
Invoke-Sqlcmd -Query $query -ServerInstance "$domain"
Restart-Service -Name MSSQLSERVER
