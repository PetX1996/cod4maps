@echo off

set GAMEDIR=%CD%
cd ..\
set MODTOOLSDIR=%CD%\origo_modtools
set GITIGNOREPATH=%GAMEDIR%\.gitignore
set GITIGNOREPARTIALPATH=%GAMEDIR%\.gitignore-partial
set CHECKSUMPATH=%GAMEDIR%\.modtoolcrc

cd %GAMEDIR%\bin\cod4maps-gitignore

cod4maps-gitignore -v -s "%GAMEDIR%" -p "%GITIGNOREPARTIALPATH%" -g "%GITIGNOREPATH%" -m "%MODTOOLSDIR%" -c "%CHECKSUMPATH%"

pause