::
:: DayZServerStart.bat
:: By: Jstrow and Danny Dorito, originally for CSG Exile
:: Minor edits and support by NIXON : https://github.com/niklashenrixon
::
@ECHO OFF
COLOR F
ECHO MESSAGE: Pre startup initialised
:: Command window name, does not affect anything else
:: Default is: DayZ Server
SET S_NAME=DayZServer
:: Path to the DayZ server executable,
:: For example: "C:\Program Files (x86)\Steam\steamapps\common\DayZServer\ or "C:\dayzserver"
:: Supports Running from different drives, for network paths, mount to drive letter or see UNC Path help
:: Cannot be blank
SET EXE_PATH="C:\Program Files (x86)\Steam\steamapps\common\DayZServer\"
:: Name of executable
:: Default is: DayZServer_x64.exe
:: Cannot be blank
SET EXE="DayZServer_x64.exe"
:: Logical CPU cores
:: To find how many you have, do echo %NUMBER_OF_PROCESSORS% in a cmd terminal
:: Default is: %NUMBER_OF_PROCESSORS%
SET CPU_CORES=%NUMBER_OF_PROCESSORS%
:: List of client side mods, Add the mod to modlist for example adding Mod3 to set modlist=@Mod1; @Mod2;
:: You would do: set modlist=-mod=@Mod1;@Mod2;@Mod3;
:: If you do not require mods, replace the line below with SET MODLIST=
SET MODLIST=-mod=
:: List of server side mods, Add the mod to servermodlist for example adding ServerMod3 to set servermodlist=@ServerMod1; @ServerMod2;
:: You would do: set SERVERMODLIST=-serverMod=@ServerMod1; @ServerMod2; @ServerMod3;
:: If you do not require server mods, replace the line below with SET SERVERMODLIST=
SET SERVERMODLIST=-serverMod=
:: Set the port number of the DayZ server, default is 2302
:: Cannot be blank or 0
SET PORT=2302
:: Set the DayZ config file
:: Default is serverDZ.cfg
:: Cannot be blank
SET CONFIG=serverDZ.cfg
:: Profile name, e.g: MyFirstDayzServer
:: Can use a file path, with environment vars, such as C:\Users\%USER%\Documents\DayZServer
:: or a string to keep the logs where EXE_PATH is
:: For more info see: https://forums.dayz.com/topic/239635-dayz-server-files-documentation/?tab=comments#comment-2396561
:: Default is: DayZServer
:: Cannot be blank
SET PROFILE=DayZServer
:: Restart timeout in seconds
:: For example, 3 hour restarts would be 3 * 60 = 10800
:: Set to 0 to disable automatic restarts
SET RESTART_TIMEOUT=10800
:: FPS limit for the server
:: Max is 200
:: Default is: 200
SET SERVER_FPS_LIMIT=200
:: Enables the BattleEye Client to monitor/admin the server and is a core process for dayz,
:: Set to true to enable, false to disable
:: Default is: true
SET USE_BEC=true
:: Path of the BattleEye Client (BEC)
:: For Example: "C:\Program Files (x86)\Steam\steamapps\common\DayZServer\BEC"
:: Cannot be blank
SET BEC_EXE_PATH="C:\Program Files (x86)\Steam\steamapps\common\DayZServer\BEC"
:: Name of BEC executable
:: Default is: "bec.exe"
:: Cannot be blank
SET BEC_EXE="bec.exe"

:: Extra launch parameters
:: For more info see: https://community.bistudio.com/wiki/DayZ:Server_Configuration
:: Default is: "-doLogs -adminLog -netLog -freezeCheck -filePatching"
SET ADDITIONAL_PARAMETERS=-doLogs -adminLog -netLog -freezeCheck -filePatching

:: Enables the DayZ SA Launcher to download mods running on the server,
:: For more info see: https://dayzsalauncher.com/#/tools
:: Set to true to enable, false to disable
:: Default is: false
SET USE_DZSAL_MODSERVER=false
:: Name of DayZ SA Launcher Mod Server exe
:: Default is: "DZSALModServer.exe"
SET EXE_DZSAL="DZSALModServer.exe"
:: Extra launch parameters
:: For more info see command line parameters section of: https://dayzsalauncher.com/#/tools
SET DZSAL_PARAMETERS=changeme

:: Steam automatic update for the server files
:: Get from here https://developer.valvesoftware.com/wiki/SteamCMD
:: Set to true to enable, false to disable
:: Default is: false
SET USE_STEAM_UPDATER=false
:: Path to the DayZ server executable, for example:  C:\Program Files (x86)\SteamCMD\
:: Cannot be blank
SET PATH_TO_STEAM_CMD_EXE="changeme"
:: Name of executable
:: Default is: "SteamCMD.exe"
:: Cannot be blank
SET STEAMCMD="SteamCMD.exe"
:: Name of the Steam account that SteamCMD uses
:: It is highly advised that you use a separate Steam account for the DayZ server if you choose to use this feature
:: 2FA may be an issues always please be careful with passwords
SET ACCOUNT_NAME=changeme
:: It is highly advised that you use a separate Steam account for the DayZ server
:: Password of the Steam account that SteamCMD uses, 2FA may be an issues always please be careful with passwords
SET ACCOUNT_PASSWORD=changeme
:: Additional apps or mods that you wish SteamCMD to update for you,
:: this will have to match the workshop item id
:: for example 2288339650 2288336145 for Namalsk
SET ADDITIONAL_ITEMS=changeme

:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ::
::             DO NOT CHANGE ANYTHING BELOW THIS POINT               ::
::               UNLESS YOU KNOW WHAT YOU ARE DOING                  ::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ::

TITLE %S_NAME%

SET ERROR=

ECHO.
ECHO MESSAGE: Starting vars checks

IF %PORT% ==0 (
	SET ERROR=PORT
	GOTO CONFIG_ERROR
)
IF %SERVER_FPS_LIMIT% GTR 200 (
	SET ERROR=SERVER_FPS_LIMIT
	GOTO CONFIG_ERROR
)
IF %SERVER_FPS_LIMIT% LEQ 1 (
	SET ERROR=SERVER_FPS_LIMIT
	GOTO CONFIG_ERROR
)
IF %USE_DZSAL_MODSERVER% ==false (
	GOTO NO_DZSAL_MODSERVER
)
IF %EXE_DZSAL% ==changeme (
	SET ERROR=EXE_DZSAL
	GOTO CONFIG_ERROR
)

IF %DZSAL_PARAMETERS% ==changeme (
	SET ERROR=DZSAL_PARAMETERS
	GOTO CONFIG_ERROR
)

:: Skip if DZSAL is disabled
:NO_DZSAL_MODSERVER

IF %USE_STEAM_UPDATER% ==false (
	GOTO NO_STEAM
)
IF %PATH_TO_STEAM_CMD_EXE% =="changeme" (
	SET ERROR=USE_STEAM_UPDATER = true so, PATH_TO_STEAM_CMD_EXE
	GOTO CONFIG_ERROR
)
IF %ACCOUNT_NAME% ==changeme (
	SET ERROR=USE_STEAM_UPDATER = true so, ACCOUNT_NAME
	GOTO CONFIG_ERROR
)
IF %ACCOUNT_PASSWORD% ==changeme (
	SET ERROR=USE_STEAM_UPDATER = true so, ACCOUNT_PASSWORD
	GOTO CONFIG_ERROR
)

:: Skip if SteamCMD update is disabled
:NO_STEAM

ECHO.
ECHO MESSAGE: Variable checks completed
SET LOOPS=0
IF %USE_STEAM_UPDATER% ==true (
	ECHO MESSAGE: Steam Automatic Update Starting
	START "%S_NAME%" /wait %PATH_TO_STEAM_CMD_EXE% %STEAMCMD% +login %ACCOUNT_NAME% %ACCOUNT_PASSWORD% +force_install_dir %EXE_PATH% +app_update 223350 %ADDITIONAL_ITEMS% validate +quit
	ECHO MESSAGE: Steam Automatic Update Completed
)
ECHO.
ECHO MESSAGE: Pre startup complete!

:LOOP
TASKLIST /FI IMAGENAME eq %EXE% 2>NUL | find /I /N %EXE% >NUL
IF %ERRORLEVEL% == 0 GOTO LOOP

ECHO MESSAGE: Starting server at: %DATE%, %TIME%
IF %LOOPS% NEQ 0 (
	ECHO MESSAGE: Restarts: %LOOPS%
)

:: Start the DayZ Server
CD /D %EXE_PATH%
START "%S_NAME%" /MIN /D %EXE_PATH% %EXE% -profiles=%PROFILE% -config=%CONFIG% -port=%PORT% -cpuCount=%CPU_CORES% -limitFPS=%SERVER_FPS_LIMIT% %MODLIST% %SERVERMODLIST% %ADDITIONAL_PARAMETERS%
ECHO MESSAGE: To stop the server, close %~nx0 then the other tasks, otherwise it will restart
:: Start BEC if true
IF %USE_BEC% ==true (
	ECHO MESSAGE: Starting BEC
	START "%S_NAME%" /MIN %EXE_DZSAL% %DZSAL_PARAMETERS%
	TIMEOUT 10
)
:: Start DZSAL Mod Server if true
IF %USE_DZSAL_MODSERVER% ==true (
	ECHO MESSAGE: Starting Mod Server
	START "%S_NAME%" /MIN %EXE_DZSAL% %DZSAL_PARAMETERS%
)

IF %RESTART_TIMEOUT% ==0 (
 GOTO RESTART_SKIP
)
TIMEOUT %RESTART_TIMEOUT%
TASKKILL /im %EXE% /F
IF %USE_DZSAL_MODSERVER% ==true (
	TASKKILL /im %EXE_DZSAL% /F
)
IF %USE_BEC% ==true (
	TASKKILL /im %BEC_EXE% /F
)
:RESTART_SKIP
TIMEOUT 30
ECHO.

:: Restart/Crash Handler
:LOOPING
SET /A LOOPS+=1
TIMEOUT /t 5
TASKLIST /FI IMAGENAME eq %EXE% 2>NUL | find /I /N %EXE% >NUL
ECHO %ERRORLEVEL%
IF %ERRORLEVEL%==0 GOTO LOOPING
GOTO LOOP

:: Generic config error catching
:CONFIG_ERROR
COLOR C
ECHO ERROR: %ERROR% not set correctly, please check the config
PAUSE
COLOR F
