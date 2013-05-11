$packageName = 'mp3tag'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.mp3tag.de/mp3tagv255asetup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url

write-host 'Integrating Mp3tag with Explorer.'

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = $($toolsDir | Split-Path | Join-Path -ChildPath "content")

#add right click menu
$infFile = join-path $contentDir 'EditWithMp3Tag.inf'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}

Get-Content $infFile | Foreach-Object{$_ -replace 'PROGRAM_FILES', "$programFiles" -replace 'CONTENT_PATH', "$contentDir"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $infFile -Force

Start-ChocolateyProcessAsAdmin "& rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 $infFile"
