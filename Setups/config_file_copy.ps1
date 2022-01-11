## Parameters
param(
    # Source for configuration files
    [string]$ConfigFileSource,
    # eManager repo root
    [string]$EManagerRepoRoot
)

## Copy to eManager repo folder root
Copy-Item $ConfigFileSource -Destination $EManagerRepoRoot -Force -Recurse
