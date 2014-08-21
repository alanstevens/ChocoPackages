$user_key = "HKCU:\Software\Microsoft\Command Processor"
$machine_key_32 = "HKLM:\Software\Microsoft\Command Processor"
$machine_key_64 = "HKLM:\Software\Wow6432Node\Microsoft\Command Processor"

$tools = Split-Path $MyInvocation.MyCommand.Definition

. (Join-Path $tools "ansicon.ps1")

Remove-AnsiconProperty -Key $user_key
Remove-AnsiconProperty -Key $machine_key_32
Remove-AnsiconProperty -Key $machine_key_64
