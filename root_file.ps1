## Parameters
Write-Host "Enter a few parameters before proceeding."
Write-Host "-----------------------------------------"
$autostore_interface_emulator_exe_location = Read-Host "Enter the AutoStore Emulator Exe Location"
$autostore_http_interface_exe_location = Read-Host "Enter the AutoStore HTTP Interface Exe Location"
$github_api_token = Read-Host "Enter your github API token"
$eManager_root_folder = Read-Host "Enter the root folder where eManager is to be cloned"
$database_name = Read-Host "Enter the database name"
$database_backup_path = Read-Host "Enter the database backup location"
$sauser = Read-Host "Enter the sysadmin SQL server username"
$sapassword = Read-Host "Enter the sysadmin SQL server password"
$config_file_source = Read-Host "Enter the hibernate config file source folder path"
$AppPoolName = Read-Host "Enter the app pool name"
$websiteFolder = Read-Host "Enter the website folder"
$websiteName = Read-Host "Enter the website name"
Write-Host "-----------------------------------------"

## Pre-requisites before installation
.\Installations\pre-requisites.ps1

## Region installers ------------------------------------------------------------------------------------------------

## Call Visual Studio Installation scripts
.\Installations\installation_visual_studio.ps1

## Call git installation
.\Installations\installation_git.ps1

## Call source tree installation
.\Installations\installation_source_tree.ps1

## Call github desktop installation
.\Installations\installation_github_desktop.ps1

## Call IIS installation
.\Installations\installation_iis.ps1

## Call SQL server and SSMS installation
.\Installations\installation_sql.ps1

## Call Autostore installation
.\Installations\installation_autostore.ps1 -AutostoreInterfaceEmulatorExeLocation $autostore_interface_emulator_exe_location -AutostoreHttpInterfaceExeLocation $autostore_http_interface_exe_location

## End Region installers ------------------------------------------------------------------------------------------------

Start-Sleep -s 300

## Region setups --------------------------------------------------------------------------------------------------------

## Site setup pre-requisites
.\Setups\site_setup_prerequisites.ps1 -OAuthToken $github_api_token -RootFolder $eManager_root_folder

## Database operations
.\Setups\database_operations.ps1 -DatabaseBackupPath $database_backup_path -DatabaseName $database_name -SAUserName $sauser -SAUserPassword $sapassword

## Package Management
.\Setups\package_management.ps1 -EManagerFolder $eManagerFolder

## Restore and build
.\Setups\restore_and_build.ps1 -EManagerFolder $eManagerFolder

## Config file copy
.\Setups\config_file_copy.ps1 -ConfigFileSource $config_file_source -EManagerRepoRoot $eManager_root_folder

## Site setup
.\Setups\site_setup.ps1 -WebsiteFolder $websiteFolder -AppPoolName $AppPoolName -WebsiteName $websiteName

## End Region setups -------------------------------------------------------------------------------------------------








