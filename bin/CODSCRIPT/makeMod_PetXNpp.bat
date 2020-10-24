cd /d D:\CoD4 Tvorba Map\Call of Duty 4 - Modern Warfare\Mods\deathrun

set spcArgs="-verbose -compareDate"
set gameArgs="+set developer 1 +set developer_script 0 +set debug 1 +set con_debug 1 +exec deathrun.cfg +set scr_DEVEnabled 1 +set g_gametype deathrun +devmap mp_dr2_orangesky"

rem verbose mainChoice ffEnable iwdEnable iwdQuality spcEnable spcSettings runEnable runType runSettings
call makeMod_ALL.bat 0 5 "" "" "" "" "" 1 1 %gameArgs%
rem pause