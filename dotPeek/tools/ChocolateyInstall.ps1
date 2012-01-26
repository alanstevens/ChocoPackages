$packageName = 'dotPeek'
$url = 'http://download-ln.jetbrains.com/dotpeek/dotPeek-1.0.0.7999.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $unzipLocation
