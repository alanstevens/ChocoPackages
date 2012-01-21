$packageName = 'ctags'
$url = 'http://sourceforge.net/projects/ctags/files/ctags/5.8/ctags58.zip'
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$file = Join-Path $tempDir "$($packageName)Install.zip"
$font = 'AndaleMo.TTF'

if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$arguments = @("e","-y","-oC:\Users\alan.stevens\AppData\Local\Temp\chocolatey\AndaleMonoFont","C:\Users\alan.stevens\AppData\Local\Temp\chocolatey\AndaleMonoFont\AndaleMonoFontInstall.zip","AndaleMo.TTF")
&"7za" @arguments

Get-ChocolateyWebFile $packageName $file $url

try {
    $arguments = @("e","-y","-o$tempDir","$file","$font")
    #& "7za" $arguments
    #copy-item $(join-path $tempDir $font) $(join-path $toolsPath $font)
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
