@echo off
set color=0a
color %color%

:START
cls
echo.
echo.   ======================================================================
echo.   I                         Kontrola slozky                            I
echo.   ======================================================================
echo.
if not exist iw3mp.exe goto ERROR
if exist iw3mp.exe goto START2

:START2
if not exist wget.exe goto ERROR2
if exist wget.exe goto BEGIN

:ERROR
echo.
echo.
echo.
echo.   ======================================================================
echo.   I                 CHYBA SOUBORY VE SPATNEM ADRESARI                  I
echo.   I           NAHRAJTE SOUBORY DO ADRESARE KDE SE VYSKYTUJE            I
echo.   I             iw3mp.exe  A DALSI SPOUSTECI SOUBORY COD4              I
echo.   ======================================================================
echo.
echo.
echo.
pause
goto END

:ERROR2
echo.
echo.
echo.
echo.   ======================================================================
echo.   I               CHYBA V ADRESARI CHYBI SOUBOR wget.exe               I
echo.   I                  NAHRAJTE SOUBOR A SPUSTE ZNOVU                    I
echo.   ======================================================================
echo.
echo.
echo.
pause
goto END


:BEGIN

del /f /q wget_graber_tools.bat
.\wget.exe http://135.4gf.cz/4gf_tools/wget_graber_tools.bat
.\wget_graber_tools.bat
quit

:END
quit