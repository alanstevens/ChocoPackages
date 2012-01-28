$packageName = 'Console-devel'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://sourceforge.net/projects/console-devel/files/console-releases/2.0b147a/Console%202.00b147a%20win32.exe'
$url64bit = 'http://sourceforge.net/projects/console-devel/files/console-releases/2.0b147a/Console%202.00b147a%20x64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$console = join-path $env:programfiles 'Console\Console.exe'
if ($is64bit) {$console = join-path  ${env:ProgramFiles(x86)} 'Console\Console.exe'}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$console = $fsObject.GetFile("$console").ShortPath

$batchFileName = Join-Path $nugetExePath "Console.bat"

"@echo off
SET DIR=%~dp0%
start $console %*" | Out-File $batchFileName -encoding ASCII
