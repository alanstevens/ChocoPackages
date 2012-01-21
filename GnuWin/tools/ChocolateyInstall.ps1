
$packageName = 'GnuWin'
$url = 'http://downloads.sourceforge.net/project/getgnuwin32/getgnuwin32/0.6.30/GetGnuWin32-0.6.3.exe'
$binRoot = "$env:systemdrive\"
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$installPath = join-path $binRoot 'GnuWin'

try {
    $chocTempDir = Join-Path $env:TEMP "chocolatey"
	$tempDir = Join-Path $chocTempDir "$packageName"
	$file = Join-Path $tempDir "$($packageName)Install.zip"
    $is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
    $programFiles = $env:ProgramFiles
    if ($is64bit) {$programFiles = $env:ProgramW6432;}
    $sevenZipPath = "$(join-path $programFiles '7-Zip')"
    $sevenZip = join-path $sevenZipPath '7z.exe'
    $toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    $extractPath = join-path $toolsPath 'GetGnuWin32'
    $binPath = join-path $extractPath 'bin'
    $downloadScript = join-path $extractPath 'download.bat'
    $installScript = join-path $extractPath 'install.bat'
    $supplementalScript = join-path $binPath 'supplemental_install.bat'
    $newDownloadScript = $downloadScript -replace '.bat','_new.bat';
    $newInstallScript  = $installScript  -replace '.bat','_new.bat';
    $newSupplementalScript  = $supplementalScript  -replace '.bat','_new.bat';

	if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

    Get-ChocolateyWebFile $packageName $file $url

    #extract file with 7zip
    $arguments = @("x","-y","-o$toolsPath","$file")
    & "$sevenZip" $arguments

    # Modify scripts to remove user input prompts
    Get-Content $downloadScript | Foreach-Object {$_ -replace "pause", ""} | Set-Content $newDownloadScript
    move-item $newDownloadScript $downloadScript -Force

    & $downloadScript

    Get-Content $supplementalScript | Foreach-Object {$_ -replace 'set /p GNUWIN32_RESPONSE=', '' -replace "pause", ""} | Set-Content $newSupplementalScript
    move-item $newSupplementalScript $supplementalScript -Force

    Get-Content $installScript | Foreach-Object{$_ -replace "pause", ""} | Set-Content $newInstallScript
    move-item $newInstallScript $installScript -Force

    & $installScript $installPath

    install-chocolateypath $(join-path $installPath 'bin')

    # prevent chocolatey from adding these files to the path unnecessarily
    remove-item -force $(join-path $binPath 'openssl.exe')
    remove-item -force $(join-path $binPath 'wget-1.12.exe')
    remove-item -force $(join-path $binPath 'findhash.exe')
    remove-item -force $(join-path $binPath 'unzip.exe')
    remove-item -force $(join-path $binPath 'sort-7.6.exe')
    remove-item -force $(join-path $binPath 'sed.exe')
    remove-item -force $(join-path $binPath 'test.exe')
    remove-item -force $(join-path $binPath 'touch.exe')
    remove-item -force $(join-path $extractPath 'cygwin_addons\info.exe')

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
