## Fetch domain and user
$domain = $env:USERDOMAIN
$user = $env:USERNAME

## Download and install SQL Server
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=866662" -UseBasicParsing -OutFile "C:\Installers\setup_sql_server.exe"
C:\Installers\setup_sql_server.exe /ACTION=Download MEDIAPATH=C:\Installers /QUIET
C:\Installers\SQLServer2019-DEV-x64-ENU.exe /q /x:C:\Installers\SQLSERVERDEV_2019
Start-Sleep -s 60
while (!([System.IO.File]::Exists("C:\Installers\SQLServer2019-DEV-x64-ENU.exe"))) { 
 }
C:\Installers\SQLSERVERDEV_2019\SETUP.EXE /Q /IACCEPTSQLSERVERLICENSETERMS /IACCEPTPYTHONLICENSETERMS="False" /IACCEPTROPENLICENSETERMS="False" /SUPPRESSPRIVACYSTATEMENTNOTICE="False" /ENU="True" /QUIETSIMPLE="False" /UpdateEnabled="True" /USEMICROSOFTUPDATE="False" /SUPPRESSPAIDEDITIONNOTICE="False" /UpdateSource="MU" /FEATURES=SQLENGINE /HELP="False" /INDICATEPROGRESS="False" /X86="False" /INSTANCENAME="MSSQLSERVER" /INSTALLSHAREDDIR="C:\Program Files\Microsoft SQL Server" /INSTALLSHAREDWOWDIR="C:\Program Files (x86)\Microsoft SQL Server" /INSTANCEID="MSSQLSERVER" /SQLTELSVCACCT="NT Service\SQLTELEMETRY" /SQLTELSVCSTARTUPTYPE="Automatic" /INSTANCEDIR="C:\Program Files\Microsoft SQL Server" /AGTSVCACCOUNT="NT Service\SQLSERVERAGENT" /AGTSVCSTARTUPTYPE="Manual" /COMMFABRICPORT="0" /COMMFABRICNETWORKLEVEL="0" /COMMFABRICENCRYPTION="0" /MATRIXCMBRICKCOMMPORT="0" /SQLSVCSTARTUPTYPE="Automatic" /FILESTREAMLEVEL="0" /SQLMAXDOP="4" /ENABLERANU="False" /SQLCOLLATION="SQL_Latin1_General_CP1_CI_AS" /SQLSVCACCOUNT="NT Service\MSSQLSERVER" /SQLSVCINSTANTFILEINIT="False" /SQLSYSADMINACCOUNTS="$domain\$user" /SQLTEMPDBFILECOUNT="4" /SQLTEMPDBFILESIZE="8" /SQLTEMPDBFILEGROWTH="64" /SQLTEMPDBLOGFILESIZE="8" /SQLTEMPDBLOGFILEGROWTH="64" /ADDCURRENTUSERASSQLADMIN="False" /TCPENABLED="0" /NPENABLED="0" /BROWSERSVCSTARTUPTYPE="Disabled" /SQLMAXMEMORY="2147483647" /SQLMINMEMORY="0" /ACTION=INSTALL

## Download and install SSMS
Invoke-WebRequest -Uri "https://aka.ms/ssmsfullsetup" -UseBasicParsing -OutFile "C:\Installers\ssms_setup.exe"
C:\Installers\ssms_setup.exe /install /quiet /norestart

Start-Sleep -s 30