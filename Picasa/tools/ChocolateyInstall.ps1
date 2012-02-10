$packageName = 'picasa'
$fileType = 'exe'
$silentArgs = '/S /L'
$url = 'http://dl.google.com/picasa/picasa39-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
