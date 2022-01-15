param(
    # Autostore interface emulator location
    [string]$AutostoreInterfaceEmulatorExeLocation,
    # Autostore interface emulator exe copy destination
    [string]$InstallersFolder
)

## Autostore emulator installation
Copy-Item "$AutostoreInterfaceEmulatorExeLocation" -Destination "${InstallersFolder}\AutoStore Interface Emulator_v1.1.9.exe"
Start-Process "${InstallersFolder}\AutoStore Interface Emulator_v1.1.9.exe" -ArgumentList @('/NORESTART', '/SILENT') -NoNewWindow -Wait
Copy-Item .\ASInterfaceEmulator.exe.config -Destination "C:\Program Files (x86)\AutoStore\AutoStore Interface Emulator\ASInterfaceEmulator.exe.config"
Start-Process "${InstallersFolder}\AutoStore Interface Emulator_v1.1.9.exe" -ArgumentList @('/NORESTART', '/SILENT') -NoNewWindow -Wait

Start-Sleep -s 30