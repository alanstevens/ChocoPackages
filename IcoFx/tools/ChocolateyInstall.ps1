$packageName = 'IcoFx'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://software-files-a.cnet.com/s/software/12/79/26/23/icofxsetup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
