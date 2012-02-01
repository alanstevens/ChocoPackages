$packageName = 'notepad2'
$fileType = 'exe'
$silentArgs = '/SILENT'
$url = 'http://www.flos-freeware.ch/zip/Notepad2_4.2.25_x86.exe'
$url64bit = 'http://www.flos-freeware.ch/zip/Notepad2_4.2.25_x64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
