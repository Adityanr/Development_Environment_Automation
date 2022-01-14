$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"

## Parameters
Write-Host "Enter a few inputs before proceeding."
Write-Host "-----------------------------------------"
$autostore_interface_emulator_exe_location = Read-Host "Enter the AutoStore Emulator Exe Location"
$autostore_http_interface_exe_location = Read-Host "Enter the AutoStore HTTP Interface Exe Location"
$github_api_token = Read-Host "Enter your github API token"
$eManager_root_folder = Read-Host "Enter the root folder where eManager is to be cloned"
$database_name = Read-Host "Enter the database name"
$database_backup_path = Read-Host "Enter the database backup location"
$sauser = Read-Host "Enter the sysadmin SQL server username"
$sapassword = Read-Host "Enter the sysadmin SQL server password" -AsSecureString
$confirmSAPassword = Read-Host "Enter the sysadmin SQL server password again to confirm" -AsSecureString

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sapassword)
$UnsecureSAPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
$BSTRConfirm = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmSAPassword)
$UnsecureConfirmSAPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTRConfirm)
if ($UnsecureSAPassword -ne $UnsecureConfirmSAPassword) {
    throw "Passwords don't match!"
}

$config_file_source = Read-Host "Enter the hibernate config file source folder path"
$wmsAppPoolName = Read-Host "Enter the WMS app pool name"
$wmsWebsiteName = Read-Host "Enter the WMS website name"
$LogsOutputPath = Read-Host "Enter the output folder for powershell script logs"
$date_and_time = Get-Date -Format MM-dd-yyyy-HH-mm
$defaultWebSitePoolName = "DefaultAppPool"
$defaultWebSiteName = "Default Web Site"
$scriptsPath = (Get-Location).Path
Write-Host "-----------------------------------------"

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

Start-Transcript -path "${LogsOutputPath}\logs_${date_and_time}.txt" -append

## Validations
$installed_visual_studio = $false
$installed_git = $false
$installed_source_tree = $false
$installed_iis = $false
$installed_sql_server = $false
$installed_ssms = $false

$SoftList = "Microsoft Visual Studio Installer","Git","Sourcetree","IIS 10.0 Express","Microsoft SQL Server 2019 (64-bit)","SQL Server Management Studio"
foreach($i in $SoftList)
{
    $x = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
    select DisplayName, Publisher, InstallDate | Where-Object {$_.DisplayName -like $("$i*")} 
    switch($x.DisplayName) {
        "Microsoft Visual Studio Installer" {
            $installed_visual_studio = $true
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
        "Microsoft SQL Server 2019 (64-bit)" {
            $installed_sql_server = $true
            break;
        } 
        "SQL Server Management Studio" {
            $installed_ssms = $true
            break;
        } 
        
    }
} 

if (!(Test-Path -Path "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSbuild.exe")) {
    $installed_visual_studio = $false
}

Write-Host "------------------------------------------------------------------------------------------------------------"
Write-Host "----------------------------------------------INSTALLATIONS STARTED----------------------------------------"
Write-Host "------------------------------------------------------------------------------------------------------------"

## Pre-requisites before installation
Write-Host "----------------------------------"
Write-Host "Pre-Requisites before installation"
.\Installations\pre-requisites.ps1
Write-Host "Pre-Requisites done"
Write-Host "----------------------------------"

## Region installers ------------------------------------------------------------------------------------------------

## Call Visual Studio Installation scripts
if (!$installed_visual_studio) {
Write-Host "---------------------------------------------"
Write-Host "Visual Studio Enterprise installation started"
    .\Installations\installation_visual_studio.ps1
Write-Host "Visual Studio Enterprise installation done"
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
    .\Installations\installation_source_tree.ps1
Write-Host "Source tree installation done"
Write-Host "---------------------------------------------"
}

## Call github desktop installation
Write-Host "---------------------------------------------"
Write-Host "GitHub desktop installation started"
    .\Installations\installation_github_desktop.ps1
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
if (!$installed_ssms -or !$installed_ssms) {
Write-Host "---------------------------------------------"
Write-Host "SQL Server and SSMS installation started"
    .\Installations\installation_sql.ps1
Write-Host "SQL Server and SSMS installation done"
Write-Host "---------------------------------------------"
}

## Call Autostore emulator installation
Write-Host "---------------------------------------------"
Write-Host "Autostore emulator installation started"
.\Installations\installation_autostore_emulator.ps1 -AutostoreInterfaceEmulatorExeLocation $autostore_interface_emulator_exe_location
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
.\Setups\site_setup_prerequisites.ps1 -OAuthToken $github_api_token -RootFolder $eManager_root_folder
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
.\Setups\package_management.ps1 -EManagerFolder $eManagerFolder
Write-Host "Package management done"
Write-Host "---------------------------"

## Restore and build
Write-Host "---------------------------"
Write-Host "Restore and build started"
cd $scriptsPath
.\Setups\restore_and_build.ps1 -EManagerFolder $eManagerFolder
cd $scriptsPath
Write-Host "Restore and build done"
Write-Host "---------------------------"

## Config file copy
Write-Host "--------------------------------"
Write-Host "Configuration files copy started"
cd $scriptsPath
.\Setups\config_file_copy.ps1 -ConfigFileSource "$config_file_source\*" -EManagerRepoRoot $eManager_root_folder
Write-Host "Configuration files copy done"
Write-Host "--------------------------------"

## Site port change
Write-Host "---------------------------------------------"
Write-Host "Port change default website to 8080 started"
cd $scriptsPath
.\Setups\site_port_change.ps1 -WebsiteName $defaultWebSiteName -PortBindingInfo "*:80:" -NewPortNumber 8080
Write-Host "Port change default website to 8080 done"

## Call autostore http interface installer
Write-Host "---------------------------------------------"
Write-Host "Autostore http interface installation started"
cd $scriptsPath
.\Installations\installation_autostore_http_interface.ps1 -AutostoreHttpInterfaceExeLocation $autostore_http_interface_exe_location
Write-Host "Autostore http interface installation done"
Write-Host "---------------------------------------------"

## Site setup WMS
Write-Host "--------------------------------------"
Write-Host "WMS web Site setups on port 80 started"
cd $scriptsPath
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








