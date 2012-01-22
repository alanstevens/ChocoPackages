$packageName = 'ctags'
$url = 'http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags58.zip'
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$unzipLocation = Join-Path $chocTempDir "$packageName"
$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$file = join-path $unzipLocation 'ctags58\ctags.exe'

Install-ChocolateyZipPackage $packageName $url $unzipLocation

try {
    copy-item $file $(join-path $toolsPath 'ctags.exe')
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
