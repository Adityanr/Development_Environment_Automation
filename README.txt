Instructions:

1) Right-click root_file.ps1 and select Run Powershell with Admin.
2) If in the above step, Run powershell with Admin is not visible, run the following script by opening PowerShell as administrator:

New-PSDrive HKCR Registry HKEY_CLASSES_ROOT | Out-Null
New-Item 'HKCR:\Microsoft.PowerShellScript.1\Shell\Run with PowerShell (Admin)' | Out-Null
New-Item 'HKCR:\Microsoft.PowerShellScript.1\Shell\Run with PowerShell (Admin)\Command' | Out-Null
Set-ItemProperty 'HKCR:\Microsoft.PowerShellScript.1\Shell\Run with PowerShell (Admin)\Command' '(Default)' '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "-Command" ""& {Start-Process PowerShell.exe -ArgumentList ''-ExecutionPolicy RemoteSigned -File \"%1\"'' -Verb RunAs}"' | Out-Null

3) Enter the input parameters and press Enter. Installation will be done automatically and logs will be displayed. UI will be shown for the sake of displaying progress, but will not require user interaction. For sample params, check for file example_parameters.txt