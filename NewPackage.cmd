@echo off
setlocal enableextensions
set OLDDIR=%CD%
:: Change to the directory containing the script
cd /d %0\..

md %1
md %1\tools
copy nuspec.template %1\%1.nuspec
copy ChocolateyInstall.template %1\tools\ChocolateyInstall.ps1

:: Return to the original directory
cd /d %OLDDIR%
