$packageName = 'ansicon'
$url = 'https://github.com/downloads/adoxa/ansicon/ansi150.zip'

$unzipLocation = Join-Path $env:TEMP "chocolatey" | Join-Path "$packageName"

Install-ChocolateyZipPackage $packageName $url $unzipLocation

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

$sourceDir = Join-Path $unzipLocation 'x86'
if($is64bit){$sourceDir = Join-Path $unzipLocation 'x64'}

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$targetDir = $(join-path $toolsDir $packageName)
move-item $sourceDir $targetDir

$registryKey = 'HKCU:\Software\Microsoft\Command Processor'
$keyProperty = 'AutoRun'
$currentValue = (Get-ItemProperty $registryKey).$keyProperty
$newValue = "$(join-path $targetDir 'ansicon.exe') -p"
Set-Item -Path $registryKey -Name $keyProperty -Value $newValue -Type string
