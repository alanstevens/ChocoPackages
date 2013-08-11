$packageName = 'dotPeek'
$installerType = 'msi'
$url = 'http://download.jetbrains.com/dotpeek/dotPeekSetup-1.1.1.33.msi'
$url64 = $url
$silentArgs = '/quiet'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
