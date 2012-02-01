$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentPath = ($toolsPath | Split-Path | Join-Path -ChildPath "content")
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

#install batch file in path
$nugetBin = join-path $env:chocolateyinstall 'bin'
$cmdFile = join-path $contentPath 'gvim.cmd'
$vimDir = join-path $env:programfiles 'vim\vim73'
if ($is64bit) {$vimDir = join-path  ${env:ProgramFiles(x86)} 'vim\vim73'}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$vimDir = $fsObject.GetFolder("$vimDir").ShortPath
Get-Content $cmdFile | Foreach-Object{$_ -replace 'VIM_DIRECTORY', "$vimDir"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $(join-path $nugetBin 'gvim.cmd') -Force

"@echo off
$(join-path $vimDir 'vim.exe') %*" | Out-File $(Join-Path $nugetBin 'vim.cmd') -encoding ASCII

#add right click menu
$infFile = join-path $contentPath 'EditWithVim.inf'

Get-Content $infFile | Foreach-Object{$_ -replace "CONTENT_PATH", "$contentPath" -replace "VIM_DIRECTORY", "$vimDir"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $infFile -Force

Start-ChocolateyProcessAsAdmin "& rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 $infFile"
