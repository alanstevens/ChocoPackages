$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$installDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url = 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.zip'

if ($is64bit) {$url = 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0%20x64.zip'}

Install-ChocolateyZipPackage 'sublimetext2' "$url" "$installDir"
