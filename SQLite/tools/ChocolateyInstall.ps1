binDir = "$env:ChocolateyInstall\bin"
Install-ChocolateyZipPackage 'SQLite' 'http://www.sqlite.org/sqlite-dll-win32-x86-3070900.zip' $binDir
