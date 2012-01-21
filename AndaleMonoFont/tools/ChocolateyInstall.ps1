$packageName = 'AndaleMonoFont'
$url = 'http://sourceforge.net/projects/corefonts/files/the%20fonts/final/andale32.exe'
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$unzipLocation = Join-Path $chocTempDir "$packageName"
$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$file = join-path $unzipLocation 'ctags58\ctags.exe'

Install-ChocolateyZipPackage $packageName $url $unzipLocation

try {
    #copy-item $file $(join-path $toolsPath 'ctags.exe')
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
