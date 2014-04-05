
function replace-content{
param([string] $infFile, [string] $contentPath)
  Get-Content "$infFile" | Foreach-Object{$_ -replace 'CONTENT_PATH', "$contentPath"} | Set-Content 'TempFile.txt'
  move-item 'TempFile.txt' "$infFile" -Force
}

$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentPath = ($toolsPath | Split-Path | Join-Path -ChildPath "content")
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

#install batch file in path
$nugetBin = join-path $env:chocolateyinstall 'bin'
$cmdFile = join-path $contentPath 'gvim.cmd'
$vimDir = join-path $env:programfiles 'vim\vim74'
if ($is64bit) {$vimDir = join-path  ${env:ProgramFiles(x86)} 'vim\vim74'}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$vimDir = $fsObject.GetFolder("$vimDir").ShortPath

Get-Content $cmdFile | Foreach-Object{$_ -replace 'VIM_DIRECTORY', "$vimDir"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $(join-path $nugetBin 'gvim.cmd') -Force

# add a batch file for the console version
"@echo off
$(join-path $vimDir 'vim.exe') %*" | Out-File $(Join-Path $nugetBin 'vim.cmd') -encoding ASCII

#add right click menu
$vimInf = join-path $contentPath 'EditWithVim.inf'

Get-Content $vimInf | Foreach-Object{$_ -replace 'CONTENT_PATH', "$contentPath" -replace 'VIM_DIRECTORY', "$vimDir"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $vimInf -Force

# Set file icons for various file types
$pythonInf = join-path $contentPath 'PythonScriptIcon.inf'
Replace-Content $pythonInf $contentPath

$rubyInf = join-path $contentPath 'RubyScriptIcon.inf'
Replace-Content $rubyInf $contentPath

$perlInf = join-path $contentPath 'PerlScriptIcon.inf'
Replace-Content $perlInf $contentPath
$scriptFile = $(Join-Path $env:temp 'Install-InfFiles.ps1')

"Foreach(`$infFile in (`"$vimInf`", `"$pythonInf`", `"$rubyInf`", `"$perlInf`"))
 {
   & rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 `$infFile
 }"| Out-File $scriptFile -encoding ASCII

Start-ChocolateyProcessAsAdmin "$scriptFile"
