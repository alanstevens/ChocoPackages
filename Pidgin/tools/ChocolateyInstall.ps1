$packageName = 'Pidgin'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/pidgin/files/Pidgin/2.10.1/pidgin-2.10.1-offline.exe'

stop-process -processname pidgin*

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
