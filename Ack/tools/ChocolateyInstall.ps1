$toolsPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$parentPath = join-path $toolsPath '..'
$contentPath = join-path $parentPath 'content'
$nugetBin = join-path $env:chocolateyinstall 'bin'
$ackScript = join-path $contentPath 'ack.pl'
$cmdFile = join-path $contentPath 'ack.cmd'
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$ackScript = $fsObject.GetFile("$ackScript").ShortPath
Get-Content $cmdFile | Foreach-Object{$_ -replace 'ACK_SCRIPT', "$ackScript"} | Set-Content 'TempFile.txt'
move-item 'TempFile.txt' $(join-path $nugetBin 'ack.cmd') -Force
