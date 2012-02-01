$toolsDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = ($toolsDir | Split-Path | Join-Path -ChildPath "content")
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

# program files path for git bash
$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$programFiles = $fsObject.GetFolder("$programFiles").ShortPath

$configTarget = join-path $env:appdata 'console\console.xml'

# rename the config file if it exists.
if(Test-Path $configTarget){
  move-item "$configTarget" "$configTarget.sav" -force }

#add custom config file
$configFile = join-path $contentDir 'console.xml'

Get-Content $configFile | Foreach-Object{$_ -replace "CONTENT_DIR", "$contentDir" -replace "PROGRAM_FILES", "$programFiles"} | Set-Content $configTarget
