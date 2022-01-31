param(
    # Autostore interface emulator location
    [string]$AutostoreInterfaceEmulatorExeLocation,
    # Autostore interface emulator exe copy destination
    [string]$InstallersFolder
)

## Autostore emulator installation
Copy-Item "$AutostoreInterfaceEmulatorExeLocation" -Destination "${InstallersFolder}"
$exePath = $AutostoreInterfaceEmulatorExeLocation.Split('\')[-1]
Start-Process "${InstallersFolder}\${exePath}" -ArgumentList @('/NORESTART', '/SILENT') -NoNewWindow -Wait

Start-Sleep -s 30