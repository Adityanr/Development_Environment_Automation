param(
    ## Installer download location
    [string]$InstallersFolder
)

## Pre-requisites

## Bypass security policy
Set-ExecutionPolicy Bypass -Scope Process -Force

## Create Installers folder
if (!(Test-Path -Path "${InstallersFolder}")) { New-Item -Path "C:\" -Name "Installers" -ItemType "directory" }

## Install NuGet
Install-PackageProvider -Name NuGet -Force

