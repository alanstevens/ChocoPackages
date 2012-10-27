$packageName = 'dotPeek'
$url = 'http://download.jetbrains.com/dotpeek/dotPeek-1.0.0.8644.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $unzipLocation
