$packageName = 'Evernote'
$installerType = 'exe'
$silentArgs = '/quiet'
$url = 'http://evernote.com/download/get.php?file=Win' # No 64-bit version available
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes