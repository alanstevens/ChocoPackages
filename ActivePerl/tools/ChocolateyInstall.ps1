$packageName = 'ActivePerl'
$fileType = 'MSI'
$binRoot = "$env:systemdrive\"

### Using an environment variable to to define the bin root until we implement YAML configuration ###
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$silentArgs = "/quiet TARGETDIR=`"$binRoot`" PERL_PATH=Yes PERL_EXT=Yes"
$url = 'http://downloads.activestate.com/ActivePerl/releases/5.20.1.2000/ActivePerl-5.20.1.2000-MSWin32-x86-64int-298557.msi'
$url64bit = 'http://downloads.activestate.com/ActivePerl/releases/5.20.1.2000/ActivePerl-5.20.1.2000-MSWin32-x64-298557.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$parentPath = join-path $toolsPath '..'
$contentPath = join-path $parentPath 'content'
$infFile = join-path $contentPath 'PerlScriptIcon.inf'

# Update the inf file with the content path
Get-Content $infFile | Foreach-Object{$_ -replace "CONTENT_PATH", "$contentPath"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $infFile -Force

# install the inf file
& rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 $infFile
