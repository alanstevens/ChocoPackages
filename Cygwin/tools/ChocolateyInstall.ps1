$binRoot = "$env:systemdrive\"
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$cygwinPath = Join-Path $binRoot 'Cygwin'
$packagePath = Join-Path $cygwinPath 'packages'
Install-ChocolateyPackage 'Cygwin' 'EXE' "$('-n -q -R ' + $cygwinPath + ' -l ' + $packagePath + ' -s http://mirror.cs.vt.edu/pub/cygwin/cygwin/ -O -C Database,Devel,Doc,Editors,Games
#Accessibility,Admin,Archive,Audio,Base,Database,Devel,Doc,Editors,Gnome,Graphics,Interpreters,Libs,Mail,Math,Mingw,Net,Perl,Publishing,Python,Science,Security,Shells,System,Text,Utils,Web,X11')" 'http://www.cygwin.com/setup.exe'
