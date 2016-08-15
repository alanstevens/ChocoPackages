$binRoot = "$env:systemdrive\"

### Using an environment variable to to define the bin root until we implement YAML configuration ###
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}

$packageArgs = @{
  packageName = 'ActivePerl'
  fileType = 'msi'
  silentArgs = "/quiet TARGETDIR=`"$binRoot`" PERL_PATH=Yes PERL_EXT=Yes"
  url = 'http://downloads.activestate.com/ActivePerl/releases/5.22.1.2201/ActivePerl-5.22.1.2201-MSWin32-x86-64int-299574.msi'
  url64bit = 'http://downloads.activestate.com/ActivePerl/releases/5.22.1.2201/ActivePerl-5.22.1.2201-MSWin32-x64-299574.msi'
  checksum = '8accceef79feedd1eec4205b0dd947d2b6c921ec1b57d1e9e61684cca4ecf7f4'
  checksumType = 'sha256'
  checksum64 = '214083166032fbf61f20bb4c65b0610508b90101910f3293b67bd56619e6444d'
  checksumType64 = 'sha256'
}
Install-ChocolateyPackage @packageArgs

$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$parentPath = join-path $toolsPath '..'
$infFile = join-path $toolsPath 'PerlScriptIcon.inf'

# Update the inf file with the content path
Get-Content $infFile | Foreach-Object{$_ -replace "CONTENT_PATH", "$toolsPath"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $infFile -Force

# install the inf file
& rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 $infFile
