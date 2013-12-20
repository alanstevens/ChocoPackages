# Msiexec really doesn't work too well when called from PowerShell.  This avoids the issue by getting cmd.exe to do the hard work.
$uninstallPath = 'cmd /c "' + (Get-ItemProperty "HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{32D39568-3B77-11E3-88CE-00163E98E7D0}" UninstallString).UninstallString + ' /quiet"'
Invoke-Expression $uninstallPath