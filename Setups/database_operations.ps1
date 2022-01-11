## Parameters
param(
    # Database backup path
    [string]$DatabaseBackupPath,
    # Database Name
    [string]$DatabaseName,
    # SA User name
    [string]$SAUserName,
    # SA User password
    [string]$SAUserPassword
)

$db_backup_path = $DatabaseBackupPath
$database_name = $DatabaseName
$SAUser = $SAUserName
$SAUserPassword = $SAUserPassword
$mssql_db_backup_path = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\${database_name}.bak"
$new_data_file_path = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\${database_name}.mdf"
$new_log_file_path = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\${database_name}_log.ldf"


## Alter SQL Authentication mode
Install-PackageProvider -Name NuGet -Force
Install-module -name SqlServer -Force -ErrorAction SilentlyContinue -Scope CurrentUser
$ErrorActionPreference = "Stop"
  
$sqlpsreg="HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.SqlServer.Management.PowerShell.sqlps150"  
  
if (Get-ChildItem $sqlpsreg -ErrorAction "SilentlyContinue")  
{  
    throw "SQL Server Provider for Windows PowerShell is not installed."  
}  
else  
{  
    $item = Get-ItemProperty $sqlpsreg  
    $sqlpsPath = "C:\Program Files (x86)\Microsoft SQL Server\150\Tools\PowerShell\Modules\SQLPS"
}  
  
$assemblylist =
"Microsoft.SqlServer.Management.Common",  
"Microsoft.SqlServer.Smo",  
"Microsoft.SqlServer.Dmf ",  
"Microsoft.SqlServer.Instapi ",  
"Microsoft.SqlServer.SqlWmiManagement ",  
"Microsoft.SqlServer.ConnectionInfo ",  
"Microsoft.SqlServer.SmoExtended ",  
"Microsoft.SqlServer.SqlTDiagM ",  
"Microsoft.SqlServer.SString ",  
"Microsoft.SqlServer.Management.RegisteredServers ",  
"Microsoft.SqlServer.Management.Sdk.Sfc ",  
"Microsoft.SqlServer.SqlEnum ",  
"Microsoft.SqlServer.RegSvrEnum ",  
"Microsoft.SqlServer.WmiEnum ",  
"Microsoft.SqlServer.ServiceBrokerEnum ",  
"Microsoft.SqlServer.ConnectionInfoExtended ",  
"Microsoft.SqlServer.Management.Collector ",  
"Microsoft.SqlServer.Management.CollectorEnum",  
"Microsoft.SqlServer.Management.Dac",  
"Microsoft.SqlServer.Management.DacEnum",  
"Microsoft.SqlServer.Management.Utility"  
  
foreach ($asm in $assemblylist)  
{  
    $asm = [Reflection.Assembly]::LoadWithPartialName($asm)  
}  
  
Push-Location  
cd $sqlpsPath  
update-FormatData -prependpath SQLProvider.Format.ps1xml
Pop-Location

$domain = $env:USERDOMAIN
$sql = [Microsoft.SqlServer.Management.Smo.Server]::new("$domain")
$sql.Settings.LoginMode = [Microsoft.SqlServer.Management.SMO.ServerLoginMode]::Mixed
$sql.Alter()

$query = @"
ALTER LOGIN [$SAUser] WITH PASSWORD='$SAUserPassword', CHECK_POLICY=OFF
GO
ALTER LOGIN [$SAUser] ENABLE
GO
"@
Invoke-Sqlcmd -Query $query -ServerInstance "$domain"
Restart-Service -Name MSSQLSERVER

## Copy backup to MSSQL backup path
Copy-Item $db_backup_path -Destination $mssql_db_backup_path

## Restore database from backup
$query = @"
RESTORE FILELISTONLY FROM DISK = '$mssql_db_backup_path'
"@
$data_log_files_old = Invoke-Sqlcmd -Query $query -ServerInstance "$domain"
$data_file_old = $data_log_files_old[0].LogicalName
$log_file_old = $data_log_files_old[1].LogicalName

$query = @"
RESTORE DATABASE [$database_name] FROM DISK = '$mssql_db_backup_path' WITH MOVE '$data_file_old' TO '$new_data_file_path',
MOVE '$log_file_old' TO '$new_log_file_path', REPLACE
"@
Invoke-Sqlcmd -Query $query -ServerInstance "$domain" -Querytimeout 0 