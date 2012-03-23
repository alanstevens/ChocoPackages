$packageName = 'tcc'
$fileType = 'exe'
$silentArgs = '/qn'
$url = 'http://jpsoft.com/downloads/v13/tccle.exe'
$url64bit = 'http://jpsoft.com/downloads/v13/tcclex64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
