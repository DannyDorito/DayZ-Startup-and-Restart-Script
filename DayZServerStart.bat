::
:: DayZServerStart.bat
:: By: Jstrow and Danny Dorito, originally for CSG Exile
::
@echo off
color F
echo Pre startup initialised
echo.
:: Command window name, does not affect anything else
:: Default is: DayZ Server
set server_name=DayZ Server

:: Path to the DayZ server executable, for example C:DayZServer\
set path_to_server_executable=changeme
:: Name of executable
:: Default is: DayZServer_x64.exe
set exe_name=DayZServer_x64.exe
:: Extra launch parameters
:: For more info see: https://forums.dayz.com/topic/239635-dayz-server-files-documentation/?tab=comments#comment-2396561
set extra_launch_parameters="-dologs -adminlog -netlog -freezecheck"
:: set the port number of the DayZ server, default ARMA is 2303
set server_port_number=0
:: set the DayZ config file, default is serverDZ.cfg
set config_name=serverDZ.cfg
::
:: DO NOT CHANGE ANYTHING BELOW THIS POINT
:: UNLESS YOU KNOW WHAT YOU ARE DOING
::
set error=""

echo.
echo Starting vars checks
title %server_name%

if "%path_to_server_executable%" == "changeme" (
	set error=path_to_server_executable
	goto error
)
if "%server_port_number%" == "0" (
	set error=server_port_number
	goto error
)
set tasklist_name=IMAGENAME eq %exe_name%

echo.
echo Variable checks completed!
echo.
set loops=0

:loop
tasklist /FI "%tasklist_name%" 2>NUL | find /I /N "%server_port_number%">NUL
if "%ERRORLEVEL%" == "0" goto loop

echo.
echo Pre startup complete!
echo.
echo Starting server at: %date%,%time%
if "%loops%" NEQ "0" (
	echo Restarts: %loops%
)

:: Start the DayZ Server
cd %path_to_server_executable%
start "%server_name%" /min /wait %exe_name% -config=%config_name% -port=%server_port_number%  %extra_launch_parameters%
echo To stop the server, close %~nx0 then the other tasks, otherwise it will restart
echo.
goto looping

:loop
:: Monitoring Loop
echo Server is already running, running monitoring loop

:looping
:: Restart/Crash Handler
set /A crashes+=1
timeout /t 5
tasklist /FI "%tasklist_name%" 2>NUL | find /I /N "%server_port_number%">NUL
if "%ERRORLEVEL%"=="0" goto loop
goto loop

:error
:: Generic error catching
color C
echo ERROR: %error% not set correctly, please check the config
pause
color F
