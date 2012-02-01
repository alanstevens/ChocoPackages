$packageName = 'notepad2'
$fileType = 'exe'
$silentArgs = '/SILENT'
$url = 'http://www.flos-freeware.ch/zip/Notepad2_4.2.25_x86.exe'
$url64bit = 'http://www.flos-freeware.ch/zip/Notepad2_4.2.25_x64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

# Add a symlink/batch file to the path
$binary = $packageName
$exePath = "$binary\$binary.exe"
# You can set this value to $true if the executable does not depend on external dlls
$useSymLinks = $true

# If the program installs somewhere other than "Program Files"
# set the $programFiles variable accordingly
$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$programFiles = $env:programfiles
if ($is64bit) {
    if($url64bit){
        $programFiles = $env:ProgramW6432}
    else{
        $programFiles = ${env:ProgramFiles(x86)}}
}

try {
    $executable = join-path $programfiles $exePath
    $fsObject = New-Object -ComObject Scripting.FileSystemObject
    $executable = $fsObject.GetFile("$executable").ShortPath

    $symLinkName = Join-Path $nugetExePath "$binary.exe"
    $batchFileName = Join-Path $nugetExePath "$binary.bat"

    # delete the batch file if it exists.
    if(Test-Path $batchFileName){Remove-Item "$batchFileName"}

    if($useSymLinks -and ((gwmi win32_operatingSystem).version -ge 6)){
        Start-ChocolateyProcessAsAdmin "if(Test-Path $symLinkName){Remove-Item $symLinkName}; $env:comspec /c mklink /H $symLinkName $executable"
      }
    else{
    "@echo off
    start $executable %*" | Out-File $batchFileName -encoding ASCII
        }
    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw
}
