$packageName = 'StrawberryPerl'
$fileType = 'MSI'
$binRoot = "$env:systemdrive\"

### Using an environment variable to to define the bin root until we implement YAML configuration ###
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$strawberryDir = join-path $binRoot 'strawberry'
$silentArgs = "/qn INSTALLDIR=`"$strawberryDir`""
$url = 'http://strawberry-perl.googlecode.com/files/strawberry-perl-5.12.3.0.msi'
$url64bit = 'http://strawberry-perl.googlecode.com/files/strawberry-perl-5.12.3.0-64bit.msi'

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
