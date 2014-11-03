$packageName = 'wizmouse'
$fileType = 'EXE'
$silentArgs = '/VERYSILENT /SP- /SUPPRESSMSGBOXES /NORESTART'
$url = 'http://antibody-software.com/files/wizmouse_1_7_0_3_setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
