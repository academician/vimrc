@ECHO OFF
CHOICE /M "Uninstall _vimrc and .vim folder symlinks in %USERPROFILE%"
IF ERRORLEVEL 2 GOTO LCancel
@dir %USERPROFILE% | find "<SYMLINKD>     .vim "
IF ERRORLEVEL 1 GOTO LError
@dir %USERPROFILE% | find "<SYMLINK>      _vimrc "
@ECHO ON
rmdir %USERPROFILE%\.vim
del %USERPROFILE%\_vimrc
@ECHO OFF
ECHO Done.
goto LEnd
:LError
ECHO Error: Not installed correctly.
goto LEnd
:LCancel
ECHO Cancelled.
:LEnd

