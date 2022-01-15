param(
    ## Installer download location
    [string]$InstallersFolder
)

## Pre-requisites

## Bypass security policy
Set-ExecutionPolicy Bypass -Scope Process -Force

## Create Installers folder
if (!(Test-Path -Path "${InstallersFolder}")) { New-Item -ItemType "directory" -Path "${InstallersFolder}" }

## Install NuGet
Install-PackageProvider -Name NuGet -Force

