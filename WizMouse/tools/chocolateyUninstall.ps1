$packageName = 'wizmouse'
$installerType = 'EXE'
$silentArgs = '/VERYSILENT /SP- /SUPPRESSMSGBOXES /NORESTART'
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$unfolder = "WizMouse" #Name of the folder here. No slashs.
$unfile = "unins000.exe" #Put the name of the uninstall file (with the extension) here. Example: unins000.exe


try {
  if (Test-Path "${Env:ProgramFiles(x86)}\$unfolder") {
    $unpath = "${Env:ProgramFiles(x86)}\$unfolder\$unfile"
  } else {
    $unpath = "$Env:ProgramFiles\$unfolder\$unfile"
  }
  Uninstall-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$unpath" -validExitCodes $validExitCodes
   
  # the following is all part of error handling
  # Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
