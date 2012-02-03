;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto end
;= rem ******************************************************************
;= rem *   Filename: aliases.bat
;= rem *Inspiration: http://ben.versionzero.org/wiki/Doskey_Macros
;= rem *    Purpose: Simple, but useful aliases; this can be done by
;= rem *             other means--of course--but this is dead simple and
;= rem *             works on EVERY Windows machine on the planet.
;= rem ******************************************************************

;= Doskey aliases
h=doskey /history

;= Directory navigation
up=cd ..

;= Fast access to Explorer
x=explorer .

;= Rails Shortcuts
s=rails s -u
s80=rails s -p 80 -u
c=rails console
sb=start http://localhost:3000

rr=rake routes
rrc=cls && rake routes
rdm=rake db:migrate $*
rdmr=rake db:migrate:redo $*
rlc=rake log:clear

;= :end
;= rem ******************************************************************
;= rem * EOF - Don't remove the following line.  It clears out the ';'
;= rem * macro. Were using it because there is no support for comments
;= rem * in a DOSKEY macro file.
;= rem ******************************************************************
;=
