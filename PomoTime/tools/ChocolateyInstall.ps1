$packageName = 'PomoTime'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://www.xoring.com/tt_bin/pomotime_v1.8.0_setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
