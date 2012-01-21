$packageName = 'Growl'
$fileType = 'msi'
$silentArgs = '/QN'
$url = 'http://www.growlforwindows.com/gfw/d.ashx?f=Growl_v2.0.8.1.zip'
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$unzipLocation = Join-Path $chocTempDir "$packageName"
$file = Join-Path $unzipLocation 'Growl_v2.0.msi'

Install-ChocolateyZipPackage $packageName $url $unzipLocation
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
