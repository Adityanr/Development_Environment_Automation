## Parameters
param(
    # Source for configuration files
    [string]$ConfigFileSource,
    # eManager repo root
    [string]$EManagerRepoRoot,
    # SA User password
    [string]$SAUserPassword
)

$hibernateConfigFile = "${EManagerRepoRoot}\hibernate.config.xml"

## Copy to eManager repo folder root
Copy-Item $ConfigFileSource -Destination $EManagerRepoRoot -Force -Recurse

## Replace data source within connection string with general one
$matchDataSource =  Select-String -Path $hibernateConfigFile ".*Data Source=([a-zA-Z0-9-_.]+);.*" -AllMatches
$matchDataSourceValue = $matchDataSource.Matches.Groups[1].Value
$dataSource = "Data Source=${matchDataSourceValue}"
if ($dataSource -ne "Data Source=.") {
    (Get-Content $hibernateConfigFile).replace($dataSource, 'Data Source=.') | Set-Content $hibernateConfigFile
}

## Replace password for sql server sa user
(Get-Content $hibernateConfigFile).replace('[PASSWORD]', "${SAUserPassword}") | Set-Content $hibernateConfigFile
