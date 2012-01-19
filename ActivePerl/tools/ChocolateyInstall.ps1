$packageName = 'ActivePerl'
$fileType = 'MSI'
$silentArgs = '/quiet'
$url = 'http://downloads.activestate.com/ActivePerl/releases/5.14.2.1402/ActivePerl-5.14.2.1402-MSWin32-x86-295342.msi'
$url64bit = 'http://downloads.activestate.com/ActivePerl/releases/5.14.2.1402/ActivePerl-5.14.2.1402-MSWin32-x64-295342.msi'
Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
