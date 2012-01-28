$packageName = 'FSViewer'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.faststonesoft.net/DN/FSViewerSetup46.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url

$toolsDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}
$fsViewer = join-path $programfiles 'FastStone Image Viewer\FSViewer.exe'

$fsObject = New-Object -ComObject Scripting.FileSystemObject
$fsViewer = $fsObject.GetFile("$fsViewer").ShortPath

#add batch file
$batchFileName = Join-Path $nugetExePath "fsviewer.bat"

"@echo off
SET DIR=%~dp0%
start $fsViewer %*" | Out-File $batchFileName -encoding ASCII
