
$packageName = 'KickAssConsole'

$toolsDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = ($toolsDir | Split-Path | Join-Path -ChildPath "content")
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64

[Environment]::SetEnvironmentVariable('TERM', 'cygwin', 'User')
[Environment]::SetEnvironmentVariable('LESS ', 'FRSX', 'User')

# program files path for git bash
$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$programFiles = $fsObject.GetFolder("$programFiles").ShortPath
$programFiles64 = $programFiles
if ($is64bit) {$programFiles64 = $env:ProgramW6432}

$targetFile = join-path $env:appdata 'console\console.xml'

#if file exists, create backup with timestamp in name
if(Test-Path $targetFile){
  $date = (Get-Date).toString('dd-MM-yyyy_hh_mm_ss')
  $baseName = [system.io.path]::GetFilenameWithoutExtension($targetFile)
  $extension = [System.IO.Path]::GetExtension($targetFile)
  $backupFile = $(join-path $env:appdata "console\$baseName`_$date$extension")
  write-host "Backing up $targetFile as $backupFile."
  move-item $targetFile $backupFile -force }

#add custom config file
$configFile = join-path $contentDir 'console.xml'
Get-Content $configFile | Foreach-Object{$_ -replace "CONTENT_DIR", "$contentDir" -replace "PROGRAM_FILES_64", "$programFiles64" -replace "PROGRAM_FILES", "$programFiles"} | Set-Content $targetFile

# Add custom aliases
$aliasFile = 'aliases.bat'
$sourceFile = "$(join-path $contentDir $aliasFile)"
$targetFile = "$(join-path $env:userprofile $aliasFile)"

#if file exists, create backup with timestamp in name
if(Test-Path $targetFile){
  $date = (Get-Date).toString('dd-MM-yyyy_hh_mm_ss')
  $baseName = [system.io.path]::GetFilenameWithoutExtension($targetFile)
  $extension = [System.IO.Path]::GetExtension($targetFile)
  $backupFile = $(join-path $env:userprofile "$baseName`_$date$extension")
  write-host "Backing up $targetFile as $backupFile."
  move-item $targetFile $backupFile -force }

copy-item $sourceFile $targetFile
