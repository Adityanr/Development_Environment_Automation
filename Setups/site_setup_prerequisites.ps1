## Parameters
param(
    # Github bearer api token
    [string]$OAuthToken,
    # eManager Repo root folder
    [string]$RootFolder,
    ## Installer download location
    [string]$InstallersFolder
)

## Setting up visual studio components for site
Start-Process "${InstallersFolder}\vs_enterprise.exe" -ArgumentList @('--wait', '--noUpdateInstaller', '--add', 'Microsoft.VisualStudio.Workload.NetWeb', '--includeRecommended', '--includeOptional', '--passive', '--norestart') -NoNewWindow -Wait
Start-Process "${InstallersFolder}\vs_enterprise.exe" -ArgumentList @('--wait', '--noUpdateInstaller', '--add', 'Microsoft.VisualStudio.Workload.ManagedDesktop', '--includeRecommended', '--includeOptional', '--passive', '--norestart') -NoNewWindow -Wait
Start-Process "${InstallersFolder}\vs_BuildTools.exe" -ArgumentList @('--wait', '--noUpdateInstaller', '--add', 'Microsoft.VisualStudio.Workload.WebBuildTools', '--includeRecommended', '--includeOptional', '--passive', '--norestart') -NoNewWindow -Wait
Start-Process "${InstallersFolder}\vs_BuildTools.exe" -ArgumentList @('--wait', '--noUpdateInstaller', '--add', 'Microsoft.VisualStudio.Workload.NetCoreBuildTools', '--includeRecommended', '--includeOptional', '--passive', '--norestart') -NoNewWindow -Wait
Start-Process "${InstallersFolder}\vs_BuildTools.exe" -ArgumentList @('--wait', '--noUpdateInstaller', '--add', 'Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools', '--includeRecommended', '--includeOptional', '--passive', '--norestart') -NoNewWindow -Wait
Start-Process "${InstallersFolder}\vs_BuildTools.exe" -ArgumentList @('--wait', '--noUpdateInstaller', '--add', 'Microsoft.VisualStudio.Workload.MSBuildTools', '--includeRecommended', '--includeOptional', '--passive', '--norestart') -NoNewWindow -Wait

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

## Update path variable
$variableNameToAdd = 'PATH'
$path_env_value = $env:PATH
$variableValueToAdd = "${path_env_value};C:\Program Files\Microsoft Visual Studio\2022\Enterprise\dotnet\runtime"
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable($variableNameToAdd, $variableValueToAdd, [System.EnvironmentVariableTarget]::User)

## Clone repository to folder
git clone "https://${OAuthToken}@github.com/ewms/AutoStoreManagementSystem.git" "${RootFolder}\eManager"
