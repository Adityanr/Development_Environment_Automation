$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"

## Parameters
Write-Host "Enter a few inputs before proceeding."
Write-Host "-----------------------------------------"
$github_api_token = Read-Host "Enter your github API token"
$eManager_root_folder = Read-Host "Enter the root folder where eManager is to be cloned"
$database_name = Read-Host "Enter the database name"
$sauser = Read-Host "Enter the sysadmin SQL server username"
$sapassword = Read-Host "Enter the sysadmin SQL server password" -AsSecureString
$confirmSAPassword = Read-Host "Enter the sysadmin SQL server password again to confirm" -AsSecureString

# password match check
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sapassword)
$UnsecureSAPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
$BSTRConfirm = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmSAPassword)
$UnsecureConfirmSAPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTRConfirm)
if ($UnsecureSAPassword -ne $UnsecureConfirmSAPassword) {
    throw "Passwords don't match!"
}

$wmsAppPoolName = Read-Host "Enter the WMS app pool name"
$wmsWebsiteName = Read-Host "Enter the WMS website name"
$LogsOutputPath = Read-Host "Enter the full path of output folder for application logs (Eg: D:\Logs)"

# pre-defined
$userprofile = $env:USERPROFILE
$database_backup_path = "C:\Backup\eet.bak"
$autostore_interface_emulator_exe_location = "C:\Installers\AutoStore Interface Emulator_v1.1.9.exe"
$autostore_http_interface_exe_location = "C:\Installers\ASInterfaceHttp_v1.5.15.exe"
$tempFolder = $env:TEMP
$installers_path = "${userprofile}\Downloads"
$config_file_source = "${userprofile}\Desktop\Config"
$PowershellLogsOutputPath = "${tempFolder}\ScriptLogs"
$date_and_time = Get-Date -Format MM-dd-yyyy-HH-mm
$defaultWebSiteName = "Default Web Site"
$scriptsPath = (Get-Location).Path
Write-Host "-----------------------------------------"
Write-Host "Pre-defined parameters:"
Write-Host "-----------------------------------------"
Write-Host "Database backup path: $database_backup_path"
Write-Host "AutoStore Emulator exe path: $autostore_interface_emulator_exe_location"
Write-Host "AutoStore HTTP interface exe path: $autostore_http_interface_exe_location"
Write-Host "Installers common folder: $installers_path"
Write-Host "Config files source folder: $config_file_source"
Write-Host "-----------------------------------------"

## Confirmation to proceed section
$title    = 'Confirm'
$question = 'Are you sure you want to proceed?'

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    Write-Host 'Starting....'
} else {
    Write-Host 'cancelled'
    exit 0
}

if (!(Test-Path -Path "${LogsOutputPath}")) { New-Item -ItemType "directory" -Path "${LogsOutputPath}" }
Start-Transcript -path "${PowershellLogsOutputPath}\logs_${date_and_time}.txt" -append

## Validations
# file path validation
if (!(Test-Path -Path "${autostore_interface_emulator_exe_location}")) {
    throw "AutoStore Emulator Exe path does not exist."
}
if (!(Test-Path -Path "${autostore_http_interface_exe_location}")) {
    throw "AutoStore HTTP Interface Exe path does not exist."
}
if (!(Test-Path -Path "${database_backup_path}")) {
    throw "Database backup path does not exist."
}
if (!(Test-Path -Path "${config_file_source}")) {
    throw "Config file source folder does not exist."
}

# installers validation
$installed_visual_studio = $false
$installed_visual_studio_build_tools = $false
$installed_git = $false
$installed_source_tree = $false
$installed_iis = $false
$installed_sql_server = $false
$installed_ssms = $false

$SoftList = "Microsoft Visual Studio Installer","Git","Sourcetree","IIS 10.0 Express","Microsoft SQL Server*","SQL Server Management Studio"
foreach($i in $SoftList)
{
    $x = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
    Select-Object DisplayName, Publisher, InstallDate | Where-Object {$_.DisplayName -like $("$i*")} 
    switch($x.DisplayName) {
        "Microsoft Visual Studio Installer" {
            $installed_visual_studio = $true
            $installed_visual_studio_build_tools = $true
            break;
        }             
        "Git" {
            $installed_git = $true
            break;
        } 
        "Sourcetree" {
            $installed_source_tree = $true
            break;
        } 
        "IIS 10.0 Express" {
            $installed_iis = $true
            break;
        }
        "SQL Server Management Studio" {
            $installed_ssms = $true
            break;
        } 
        
    }

    if($x.DisplayName -like "Microsoft SQL Server*") {
        $installed_sql_server = $true
    }
} 

$ErrorActionPreference="SilentlyContinue"
$vsEnterpriseMSBuildPath = (resolve-path "C:\Program Files\Microsoft Visual Studio\*\Enterprise\MSBuild\Current\Bin\MSbuild.exe").Path
$ErrorActionPreference="Continue"
if (!($vsEnterpriseMSBuildPath)) {
    $installed_visual_studio = $false
}

$ErrorActionPreference="SilentlyContinue"
$vsBuildToolsMSBuildPath = (resolve-path "C:\Program Files (x86)\Microsoft Visual Studio\*\BuildTools\MSBuild\Current\Bin\MSbuild.exe").Path
$ErrorActionPreference="Continue"
if (!($vsBuildToolsMSBuildPath)) {
    $installed_visual_studio_build_tools = $false
}

Write-Host "------------------------------------------------------------------------------------------------------------"
Write-Host "----------------------------------------------INSTALLATIONS STARTED----------------------------------------"
Write-Host "------------------------------------------------------------------------------------------------------------"

## Pre-requisites before installation
Write-Host "----------------------------------"
Write-Host "Pre-Requisites before installation"
.\Installations\pre-requisites.ps1 -InstallersFolder $installers_path
Write-Host "Pre-Requisites done"
Write-Host "----------------------------------"

## Region installers ------------------------------------------------------------------------------------------------

## Call Visual Studio Installation scripts
if (!$installed_visual_studio) {
Write-Host "---------------------------------------------"
Write-Host "Visual Studio Enterprise installation started"
    .\Installations\installation_visual_studio.ps1 -InstallersFolder $installers_path
Write-Host "Visual Studio Enterprise installation done"
Write-Host "---------------------------------------------"
}

## Call Visual Studio Build tools Installation scripts
if (!$installed_visual_studio_build_tools) {
Write-Host "---------------------------------------------"
Write-Host "Visual Studio Build tools installation started"
    .\Installations\installation_visual_studio_build_tools.ps1 -InstallersFolder $installers_path
Write-Host "Visual Studio Build tools installation done"
Write-Host "---------------------------------------------"
}

## Call git installation
if (!$installed_git) {
Write-Host "---------------------------------------------"
Write-Host "Git installation started"
    .\Installations\installation_git.ps1
Write-Host "Git installation done"
Write-Host "---------------------------------------------"
}

## Call source tree installation
if (!$installed_source_tree) {
Write-Host "---------------------------------------------"
Write-Host "Source tree installation started"
    .\Installations\installation_source_tree.ps1 -InstallersFolder $installers_path
Write-Host "Source tree installation done"
Write-Host "---------------------------------------------"
}

## Call github desktop installation
Write-Host "---------------------------------------------"
Write-Host "GitHub desktop installation started"
    .\Installations\installation_github_desktop.ps1 -InstallersFolder $installers_path
Write-Host "GitHub desktop installation done"
Write-Host "---------------------------------------------"

## Call IIS installation
if (!$installed_iis) {
Write-Host "---------------------------------------------"
Write-Host "IIS installation started"
    .\Installations\installation_iis.ps1
Write-Host "IIS installation done"
Write-Host "---------------------------------------------"
}

## Call SQL server and SSMS installation
if (!$installed_sql_server -or !$installed_ssms) {
Write-Host "---------------------------------------------"
Write-Host "SQL Server and SSMS installation started"
    .\Installations\installation_sql.ps1 -InstallersFolder $installers_path
Write-Host "SQL Server and SSMS installation done"
Write-Host "---------------------------------------------"
}

## Call Autostore emulator installation
Write-Host "---------------------------------------------"
Write-Host "Autostore emulator installation started"
.\Installations\installation_autostore_emulator.ps1 -AutostoreInterfaceEmulatorExeLocation $autostore_interface_emulator_exe_location -InstallersFolder $installers_path
Write-Host "---------------------------------------------"
Write-Host "Autostore emulator installation done"

Write-Host "------------------------------------------------------------------------------------------------------------"
Write-Host "-----------------------------------------------INSTALLATIONS DONE------------------------------------------"
Write-Host "------------------------------------------------------------------------------------------------------------"

## End Region installers ------------------------------------------------------------------------------------------------

Start-Sleep -s 30

## Region setups --------------------------------------------------------------------------------------------------------

Write-Host "------------------------------------------------------------------------------------------------------------"
Write-Host "-------------------------------------------------SETUPS STARTED---------------------------------------------"
Write-Host "------------------------------------------------------------------------------------------------------------"

## Site setup pre-requisites
Write-Host "------------------------------------"
Write-Host "Pre-requisites before setups started"
.\Setups\site_setup_prerequisites.ps1 -OAuthToken $github_api_token -RootFolder $eManager_root_folder -InstallersFolder $installers_path
Write-Host "Pre-requisites before setups done"
Write-Host "------------------------------------"

## Database operations
Write-Host "---------------------------"
Write-Host "Database operations started"
.\Setups\database_operations.ps1 -DatabaseBackupPath $database_backup_path -DatabaseName $database_name -SAUserName $sauser -SAUserPassword $UnsecureSAPassword
Write-Host "Database operations done"
Write-Host "---------------------------"

## Package Management
Write-Host "---------------------------"
Write-Host "Package management started"
$eManagerFolder = "${eManager_root_folder}\eManager"
.\Setups\package_management.ps1 -EManagerFolder $eManagerFolder -InstallersFolder $installers_path
Write-Host "Package management done"
Write-Host "---------------------------"

## Restore and build
Write-Host "---------------------------"
Write-Host "Restore and build started"
Set-Location $scriptsPath
.\Setups\restore_and_build.ps1 -EManagerFolder $eManagerFolder -InstallersFolder $installers_path
Set-Location $scriptsPath
Write-Host "Restore and build done"
Write-Host "---------------------------"

## Config file copy
Write-Host "--------------------------------"
Write-Host "Configuration files copy started"
Set-Location $scriptsPath
.\Setups\config_file_copy.ps1 -ConfigFileSource "${config_file_source}\*" -EManagerRepoRoot $eManager_root_folder -SAUserPassword $UnsecureSAPassword
Write-Host "Configuration files copy done"
Write-Host "--------------------------------"

## Site port change
Write-Host "---------------------------------------------"
Write-Host "Port change default website to 8080 started"
Set-Location $scriptsPath
.\Setups\site_port_change.ps1 -WebsiteName $defaultWebSiteName -PortBindingInfo "*:80:" -NewPortNumber 8080
Write-Host "Port change default website to 8080 done"

## Call autostore http interface installer
Write-Host "---------------------------------------------"
Write-Host "Autostore http interface installation started"
Set-Location $scriptsPath
.\Installations\installation_autostore_http_interface.ps1 -AutostoreHttpInterfaceExeLocation $autostore_http_interface_exe_location -InstallersFolder $installers_path
Write-Host "Autostore http interface installation done"
Write-Host "---------------------------------------------"

## Site setup WMS
Write-Host "--------------------------------------"
Write-Host "WMS web Site setups on port 80 started"
Set-Location $scriptsPath
$wmsWebsiteFolder = "${eManager_root_folder}\eManager\WmsWeb"
.\Setups\site_setup_wms.ps1 -WebsiteFolder $wmsWebsiteFolder -AppPoolName $wmsAppPoolName -WebsiteName $wmsWebsiteName -PortNumber 80
Write-Host "WMS web Site setups on port 80 done"
Write-Host "--------------------------------------"

Write-Host "------------------------------------------------------------------------------------------------------------"
Write-Host "--------------------------------------------------SETUPS DONE-----------------------------------------------"
Write-Host "------------------------------------------------------------------------------------------------------------"

## End Region setups -------------------------------------------------------------------------------------------------

Stop-Transcript

write-host "Press any key to continue..."
[void][System.Console]::ReadKey($true)








