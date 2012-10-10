try {
  $package = 'SublimeText2'
  #uses InnoSetup - http://unattended.sourceforge.net/InnoSetup_Switches_ExitCodes.html
  Install-ChocolateyPackage 'Sublime Text 2.0.1 Setup' 'exe' '/VERYSILENT /NORESTART /TASKS="contextentry"' `
    'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1%20Setup.exe' `
    'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1%20x64%20Setup.exe'

  # install package control
  $installPath = Join-Path $Env:ProgramFiles 'Sublime Text 2'
  $sublimeDataPath = Join-Path ([System.Environment]::GetFolderPath('ApplicationData')) 'Sublime Text 2'
  $packagesPath = Join-Path $sublimeDataPath 'Installed Packages'
  if (!(Test-Path $packagesPath)) { New-Item $packagesPath -Type Directory }
  $packageControl = Join-Path $packagesPath 'Package Control.sublime-package'

  if (!(Test-Path $packageControl))
  {
    $packageUrl = 'http://sublime.wbond.net/Package%20Control.sublime-package'
    Get-ChocolateyWebFile -url $packageUrl -fileFullPath $packageControl
  }

  # add subl alias to powershell profile
  if (!(Test-Path function:subl))
  {
    'function subl { &"${Env:ProgramFiles}\Sublime Text 2\sublime_text.exe" $args }' |
      Out-File -FilePath $PROFILE -Append -Encoding UTF8
    Write-Host 'Added subl alias to Powershell profile to launch Sublime Text 2'
  }

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
