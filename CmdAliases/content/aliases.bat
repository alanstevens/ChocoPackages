;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto :end
;= rem ******************************************************************
;= rem *   Filename: aliases.bat
;= rem *     Source: http://ben.versionzero.org/wiki/Doskey_Macros
;= rem *    Version: 1.0
;= rem *     Author: Ben Burnett <me@cs.wisc.edu>
;= rem *    Purpose: Simple, but useful aliases; this can be done by
;= rem *             other means--of course--but this is dead simple and
;= rem *             works on EVERY Windows machine on the planet.
;= rem *    History:
;= rem * 22/01/2002: File Created (Syncrude Canada).
;= rem * 01/05/2007: Updated author's address, added new macros, a
;= rem *             history and some new helpful comments.
;= rem * 19/06/2007: Added Notepad, Explorer and Emacs macros.
;= rem * 20/06/2007: Fixed doskey macrofile= path problem: it is now not
;= rem *             a relative path, so it can be called from anywhere.
;= rem ******************************************************************

;= Doskey aliases
h=doskey /history

;= File listing enhancements
:=ls=dir /x $*
l=dir /x $*
ll=dir /w $*
la=dir /x /a $*

;= Directory navigation
up=cd ..
pd=pushd

;= Copy and move macros
;=cp=copy
:=mv=move

;= Delete macros
;=rm=del /p $*
rmf=del /q $*
rmtmp=del /q *~ *# 2>nul

;= Fast access to Notepad
n=notepad $*

;= Fast access to Explorer
x=explorer .

;= :end
;= rem ******************************************************************
;= rem * EOF - Don't remove the following line.  It clears out the ';'
;= rem * macro. We're using it because there is no support for comments
;= rem * in a DOSKEY macro file.
;= rem ******************************************************************
;=
