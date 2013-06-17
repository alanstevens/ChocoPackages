$packageName = 'wizmouse'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://antibody-software.com/files/wizmouse_1_6_0_2_setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
