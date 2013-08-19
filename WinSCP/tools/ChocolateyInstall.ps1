$packageName = 'winscp'
$url = 'http://prdownloads.sourceforge.net/winscp/winscp517.zip'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Install-ChocolateyZipPackage $packageName $url $toolsDir
