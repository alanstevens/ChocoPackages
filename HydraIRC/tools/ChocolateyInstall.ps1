$packageName = 'hydrairc'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.hydrairc.com/downloads/HydraIRC.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url

$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
$file = Join-Path $tempDir "$($packageName)Install.zip"
$toolsDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = ($toolsDir | Split-Path | Join-Path -ChildPath "content")

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}

$executable = join-path $programfiles 'HydraIRC\HydraIRC.exe'

$fsObject = New-Object -ComObject Scripting.FileSystemObject
$executable = $fsObject.GetFile("$executable").ShortPath

#add batch file
$batchFileName = Join-Path $nugetExePath "$packageName.bat"

"@echo off
SET DIR=%~dp0%
start $executable %*" | Out-File $batchFileName -encoding ASCII
