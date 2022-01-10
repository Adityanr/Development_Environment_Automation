## Pre-requisites

## Bypass security policy
Set-ExecutionPolicy Bypass -Scope Process -Force

## Create Installers folder
New-Item -Path "C:\" -Name "Installers" -ItemType "directory"

## Install NuGet
Install-PackageProvider -Name NuGet -Force

