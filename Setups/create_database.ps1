$domain = $env:USERDOMAIN
$sql = [Microsoft.SqlServer.Management.Smo.Server]::new("$domain")
$db = New-Object Microsoft.SqlServer.Management.Smo.Database($sql, "eet")
$db.Create()
Write-Host $db.CreateDate