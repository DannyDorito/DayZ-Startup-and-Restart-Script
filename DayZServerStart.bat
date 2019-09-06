::
:: DayZServerStart.bat
:: By: Jstrow and Danny Dorito, originally for CSG Exile
:: Minor edits by NIXON : https://github.com/niklashenrixon
::
@ECHO off
ECHO Pre startup initialised
COLOR F

:: Command window name, does not affect anything else
:: Default is: DayZ Server
SET S_NAME=DayZ Server

:: Path to the DayZ server executable, for example:  C:\Program Files (x86)\Steam\steamapps\common\DayZServer
SET EXE_PATH=changeme

:: Name of executable
:: Default is: DayZServer_x64.exe
SET EXE=DayZServer_x64.exe

:: Extra launch parameters
:: For more info see: https://forums.dayz.com/topic/239635-dayz-server-files-documentation/?tab=comments#comment-2396561
SET PARAMETERS=-doLogs -adminLog -netLog -freezeCheck

:: Set the port number of the DayZ server, default is 2302
SET PORT=0

:: Set the DayZ config file, default is serverDZ.cfg
SET CONFIG=serverDZ.cfg

:: Profile name, e.g: MyFirstDayzServer
SET PROFILE=changeme


:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ::
::             DO NOT CHANGE ANYTHING BELOW THIS POINT               ::
::               UNLESS YOU KNOW WHAT YOU ARE DOING                  ::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ::

TITLE %S_NAME%

SET ERROR=""

ECHO.
ECHO Starting vars checks

IF "%EXE_PATH%" == "changeme" (
	SET ERROR=EXE_PATH
	GOTO ERROR
	)

IF "%PORT%" == "0" (
	SET ERROR=PORT
	GOTO ERROR
	)

IF "%PROFILE%" == "changeme" (
	SET ERROR=PROFILE
	GOTO ERROR
	)

SET T_NAME=IMAGENAME eq %EXE%

ECHO.
ECHO Variable checks completed!
SET LOOPS=0

:LOOP
TASKLIST /FI "%T_NAME%" 2>NUL | find /I /N "%PORT%">NUL
IF "%ERRORLEVEL%" == "0" GOTO LOOP

ECHO.
ECHO Pre startup complete!
ECHO Starting server at: %DATE%,%TIME%
IF "%LOOPS%" NEQ "0" (
	ECHO Restarts: %LOOPS%
)

:: Start the DayZ Server
CD %EXE_PATH%
START "%S_NAME%" /wait %EXE% -config=%CONFIG% -profiles=%PROFILE% -port=%PORT% %PARAMETERS%
ECHO To stop the server, close %~nx0 then the other tasks, otherwise it will restart
ECHO.
GOTO LOOPING

:: Monitoring Loop
:LOOP
ECHO Server is already running, running monitoring loop

:: Restart/Crash Handler
:LOOPING
SET /A LOOPS+=1
TIMEOUT /t 5
TASKLIST /FI "%T_NAME%" 2>NUL | find /I /N "%PORT%">NUL
IF "%ERRORLEVEL%"=="0" GOTO LOOP
GOTO loop

:: Generic error catching
:ERROR
COLOR C
ECHO ERROR: %ERROR% not set correctly, please check the config
PAUSE
COLOR F
