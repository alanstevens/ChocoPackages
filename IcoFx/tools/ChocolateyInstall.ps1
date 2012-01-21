$packageName = 'IcoFx'
$fileType = 'exe'
$silentArgs = '/silent'
$url = 'http://filehippo.com/download/file/5c8e13c8a6cb4f275342e5955614ef913002db23816d1e12f6eccb19bde5b1c3/'
Install-ChocolateyPackage $packageName $fileType $silentArgs $url
