$cygwinPath = Join-Path $env:SystemDrive 'cygwin'
$packagePath = Join-Path $cygwinPath 'packages'
Install-ChocolateyPackage 'Cygwin' 'EXE' "$('-n -q -R ' + $cygwinPath + ' -l ' + $packagePath + ' -s http://mirror.cs.vt.edu/pub/cygwin/cygwin/ -O -C Base, Shells
#Accessibility,Admin,Archive,Audio,Base,Database,Devel,Doc,Editors,Gnome,Graphics,Interpreters,Libs,Mail,Math,Mingw,Net,Perl,Publishing,Python,Science,Security,Shells,System,Text,Utils,Web,X11')" 'http://www.cygwin.com/setup.exe'
