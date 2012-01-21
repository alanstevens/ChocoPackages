$packageName = 'ActivePerl'
$fileType = 'MSI'
$binRoot = "$env:systemdrive\"
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$silentArgs = '/quiet TARGETDIR="$binRoot" PERL_PATH=Yes PERL_EXT=Yes'
$url = 'http://downloads.activestate.com/ActivePerl/releases/5.14.2.1402/ActivePerl-5.14.2.1402-MSWin32-x86-295342.msi'
$url64bit = 'http://downloads.activestate.com/ActivePerl/releases/5.14.2.1402/ActivePerl-5.14.2.1402-MSWin32-x64-295342.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
