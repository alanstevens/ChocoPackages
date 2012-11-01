$packageName = 'evernote'
$fileType = 'exe'
$silentArgs = '/quiet'
$url = 'http://evernote.s3.amazonaws.com/win4/public/Evernote_4.5.10.7472.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
