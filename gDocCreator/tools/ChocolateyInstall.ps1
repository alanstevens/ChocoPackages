$packageName = 'gdoc-creator'
$fileType = 'exe'
$silentArgs = '/s'
$url = 'http://downloads.globalgraphics.com/gdoc/gDocInstaller_x86_EN_251.zip'
$url64bit = 'http://downloads.globalgraphics.com/gdoc/gDocInstaller_x64_EN_251.zip'

$unzipLocation = Join-Path $env:TEMP "chocolatey" | Join-Path "$packageName"

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
if ($is64bit) {$url = $url64bit}

$fileName = 'gDocInstaller_x86_EN_251.exe'
if ($is64bit) {$fileName = 'gDocInstaller_x64_EN_251.exe'}
$file = Join-Path $unzipLocation "$fileName"

#Install-ChocolateyZipPackage $packageName $url $unzipLocation

Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
C:\Users\ALAN~1.STE\AppData\Local\Temp\chocolatey\gdoc-creator\gDocInstaller_x86_EN_251.exe
