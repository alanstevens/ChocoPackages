$packageName = 'wizmouse'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://antibody-software.com/files/wizmouse_1_7_0_3_setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
