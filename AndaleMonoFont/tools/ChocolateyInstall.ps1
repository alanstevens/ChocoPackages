$packageName = 'AndaleMonoFont'
$url = 'http://sourceforge.net/projects/corefonts/files/the%20fonts/final/andale32.exe'
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$file = Join-Path $tempDir "$($packageName)Install.zip"
$font = 'AndaleMo.TTF'

if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

Get-ChocolateyWebFile $packageName $file $url

$arguments = @("e","-y","-oC:\Users\alan.stevens\AppData\Local\Temp\chocolatey\AndaleMonoFont","C:\Users\alan.stevens\AppData\Local\Temp\chocolatey\AndaleMonoFont\AndaleMonoFontInstall.zip","AndaleMo.TTF")
&"7za" @arguments

try {
    $arguments = @("e","-y","-o$tempDir","$file","$font")
    #& "7za" $arguments
    #copy-item $(join-path $tempDir $font) $(join-path $toolsPath $font)
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
