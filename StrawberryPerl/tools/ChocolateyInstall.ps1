$packageName = 'StrawberryPerl'
$fileType = 'MSI'
$binRoot = "$env:systemdrive\"

### Using an environment variable to to define the bin root until we implement YAML configuration ###
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$strawberryDir = join-path $binRoot 'strawberry'
$silentArgs = "/qn INSTALLDIR=`"$strawberryDir`""
$url = 'http://strawberry-perl.googlecode.com/files/strawberry-perl-5.16.3.1-32bit.msi'
$url64bit = 'http://strawberry-perl.googlecode.com/files/strawberry-perl-5.16.3.1-64bit.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
