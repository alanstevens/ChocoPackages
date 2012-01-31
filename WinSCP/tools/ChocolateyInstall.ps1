$packageName = 'winscp'
$url = 'http://prdownloads.sourceforge.net/winscp/winscp505.zip'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Install-ChocolateyZipPackage $packageName $url $toolsDir
