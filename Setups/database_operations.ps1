## Parameters
$db_backup_path = "C:\Backups\eet.bak"
$mssql_db_backup_path = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\eet.bak"
$new_data_file_path = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\eet.mdf"
$new_log_file_path = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\eet_log.ldf"
$SAUser = "sa"
$SAUserPassword = "ELJan2022#"
$database_name = "eet"


## Alter SQL Authentication mode
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