$id = "ansicon"
$url = "https://github.com/adoxa/ansicon/releases/download/v1.66/ansi166.zip"

$user_key = "HKCU:\Software\Microsoft\Command Processor"
$machine_key_32 = "HKLM:\Software\Microsoft\Command Processor"
$machine_key_64 = "HKLM:\Software\Wow6432Node\Microsoft\Command Processor"

$is64bit = Get-ProcessorBits 64
$subfolder = @{$true="x64";$false="x86"}

$tools = Split-Path $MyInvocation.MyCommand.Definition
$content = Join-Path (Split-Path $tools) "content"
$ansicon = Join-Path $content (Join-Path $subfolder[$is64bit] $id)
$ignore = Join-Path $content (Join-Path $subfolder[-not $is64bit] "$id.exe.ignore")

Install-ChocolateyZipPackage $id $url $content

New-Item $ignore -Type File -Force | Out-Null

. (Join-Path $tools "ansicon.ps1")

Remove-AnsiconProperty -Key $user_key
Set-AnsiconProperty -Key $machine_key_32 -Ansicon $ansicon
Set-AnsiconProperty -Key $machine_key_64 -Ansicon $ansicon
