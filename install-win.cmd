@ECHO OFF
CHOICE /M "Install _vimrc and .vim folder symlinks in %USERPROFILE%"
IF ERRORLEVEL 2 GOTO LCancel
@ECHO ON
MKLINK %USERPROFILE%\_vimrc %~dp0.vimrc
MKLINK /D %USERPROFILE%\.vim %~dp0.vim
@ECHO OFF
ECHO Done.
goto LEnd
:LCancel
ECHO Cancelled.
:LEnd

