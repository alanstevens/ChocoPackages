$packageName = 'IcoFx'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://files1.freewareupdate.com/192874754126375148716237182368754817281726815412512512314/images-photos/icofx-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
