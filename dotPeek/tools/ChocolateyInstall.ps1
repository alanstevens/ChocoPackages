$packageName = 'dotPeek'
$url = 'http://download-ln.jetbrains.com/dotpeek/dotPeekSetup-1.0.0.8644.msi'
Install-ChocolateyPackage $packageName 'msi' '/quiet' $url
