::
:: DayZServerStart.bat
:: By: Jstrow and Danny Dorito, originally for CSG Exile
:: Minor edits by NIXON : https://github.com/niklashenrixon
::
@ECHO off
COLOR F
ECHO MESSAGE: Pre startup initialised

:: Command window name, does not affect anything else
:: Default is: DayZ Server
SET S_NAME=DayZ Server
:: Path to the DayZ server executable, for example:  C:\Program Files (x86)\Steam\steamapps\common\DayZServer or C:\dayzserver
:: Cannot be blank or 'changeme'
SET EXE_PATH=changeme
:: Name of executable
:: Default is: DayZServer_x64.exe
:: Cannot be blank
SET EXE=DayZServer_x64.exe
:: List of client side mods, Add the mod to modlist for example adding Mod3 to set modlist=@Mod1; @Mod2;
:: You would do: set modlist=@Mod1; @Mod2; @Mod3
:: Cannot be '@Mod1; @Mod2; @Mod3;'
set MODLIST=@Mod1; @Mod2; @Mod3;
:: List of server side mods, Add the mod to servermodlist for example adding ServerMod3 to set servermodlist=@ServerMod1; @ServerMod2;
:: You would do: set SERVERMODLIST=@ServerMod1; @ServerMod2; @ServerMod3;
set SERVERMODLIST=
:: Set the port number of the DayZ server, default is 2302
:: Cannot be blank or 0
SET PORT=2302
:: Set the DayZ config file, default is serverDZ.cfg
:: Cannot be blank
SET CONFIG=serverDZ.cfg
:: Profile name, e.g: MyFirstDayzServer
:: Cannot be blank or 'changeme'
SET PROFILE=changeme

:: Extra launch parameters
:: For more info see: https://forums.dayz.com/topic/239635-dayz-server-files-documentation/?tab=comments#comment-2396561
SET ADDITIONAL_PARAMETERS=-doLogs -adminLog -netLog -freezeCheck

:: Enables the DayZ SA Launcher to download mods running on the server,
:: For more info see: https://dayzsalauncher.com/#/tools
:: Set to true to enable, false to disable
:: Default is: false
SET USE_DZSAL_MODSERVER=false
:: Name of DayZ SA Launcher Mod Server exe
:: Default is: DZSALModServer.exe
SET EXE_DZSAL=DZSALModServer.exe
:: Extra launch parameters
:: For more info see command line parameters section of: https://dayzsalauncher.com/#/tools
SET DZSAL_PARAMETERS=changeme

:: Steam automatic update for the server files
:: Get from here https://developer.valvesoftware.com/wiki/SteamCMD
:: Set to true to enable, false to disable
:: Default is: false
SET %USE_STEAM_UPDATER%=false
:: Path to the DayZ server executable, for example:  C:\Program Files (x86)\SteamCMD
SET %PATH_TO_STEAM_CMD_EXE%=changeme
:: Name of the Steam account that SteamCMD uses
:: It is highly advised that you use a separate Steam account for the DayZ server if you choose to use this feature
:: 2FA may be an issues always please be careful with passwords
SET %ACCOUNT_NAME%=changeme
:: It is highly advised that you use a separate Steam account for the DayZ server
:: Password of the Steam account that SteamCMD uses, 2FA may be an issues always please be careful with passwords
SET %ACCOUNT_PASSWORD%=changeme
:: Addition apps or mods that you wish SteamCMD to update for you, this will have to match the workshop item id, for example 2288339650 2288336145 for Namalsk
SET %ADDITIONAL_ITEMS%=

:: If you are using the SQL backup set backup=true
:: Default is false
set BACKUP=false
:: set the directory to the .bat filePatching, for example C:ARMA\backup.bat
set PATH_TO_SQL_BACKUP=changeme
:: if you want the script to move the created SQL backup to another directory, set move_backup=true
:: Default is false
set MOVE_BACKUP=false
:: directory to move the files FROM, for example C:ARMA/backup
set Backup=changeme
:: directory to move files TO, for example C:/dropbox
set BACKUP_TO=changeme

:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ::
::             DO NOT CHANGE ANYTHING BELOW THIS POINT               ::
::               UNLESS YOU KNOW WHAT YOU ARE DOING                  ::
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: ::

TITLE %S_NAME%

SET ERROR=""

ECHO.
ECHO MESSAGE: Starting vars checks

IF "%EXE_PATH%" == "changeme" (
	SET ERROR=EXE_PATH
	GOTO ERROR
)
IF [%EXE_PATH%] == [] (
	SET ERROR=EXE_PATH
	GOTO ERROR
)

IF [%EXE%] == [] (
	SET ERROR=EXE
	GOTO ERROR
)

IF [%CONFIG%] == [] (
	SET ERROR=CONFIG
	GOTO ERROR
)

IF %PORT% == 0 (
	SET ERROR=PORT
	GOTO ERROR
)
IF [%PORT%] == [] (
	SET ERROR=PORT
	GOTO ERROR
)

IF "%PROFILE%" == "changeme" (
	SET ERROR=PROFILE
	GOTO ERROR
)
IF [%PROFILE%] == [] (
	SET ERROR=PROFILE
	GOTO ERROR
)

IF "%MODS%" == "@Mod1; @Mod2; @Mod3;" (
	SET ERROR=MODS
	GOTO ERROR
)

IF "%USE_DZSAL_MODSERVER%" == "true" (
	IF "%DZSAL_PARAMETERS%" == "changeme" (
		SET ERROR=DZSAL_PARAMETERS
		GOTO ERROR
	)
	IF [%EXE_PATH%] == [] (
		SET ERROR=DZSAL_PARAMETERS
		GOTO ERROR
	)
)

IF "%USE_STEAM_UPDATER%" == "true" (
	IF "%PATH_TO_STEAM_CMD_EXE%" == "changeme" (
		SET ERROR=USE_STEAM_UPDATER = true so, PATH_TO_STEAM_CMD_EXE
		GOTO ERROR
	)
	IF "%ACCOUNT_NAME%" == "changeme" (
		SET ERROR=USE_STEAM_UPDATER = true so, ACCOUNT_NAME
		GOTO ERROR
	)
	IF "%ACCOUNT_PASSWORD%" == "changeme" (
		SET ERROR=USE_STEAM_UPDATER = true so, ACCOUNT_PASSWORD
		GOTO ERROR
	)
	IF [%PATH_TO_STEAM_CMD_EXE%] == [] (
		SET ERROR=USE_STEAM_UPDATER = true so, PATH_TO_STEAM_CMD_EXE
		GOTO ERROR
	)
	IF [%ACCOUNT_NAME%] == [] (
		SET ERROR=USE_STEAM_UPDATER = true so, ACCOUNT_NAME
		GOTO ERROR
	)
	IF [%ACCOUNT_PASSWORD%] == [] (
		SET ERROR=USE_STEAM_UPDATER = true so, ACCOUNT_PASSWORD
		GOTO ERROR
	)
)

IF "%BACKUP%" == "true"(
	IF "%MOVE_BACKUP%" == "true" (
		IF "%BACKUP_FROM%" == "changeme" (
			SET ERROR=BACKUP_FROM
			GOTO ERROR
		)
		IF [%BACKUP_FROM%] == [] (
			SET ERROR=MOVE_BACKUP = true so, BACKUP_FROM
			GOTO ERROR
		)
		IF "%BACKUP_TO%" == "changeme" (
			SET ERROR=BACKUP_TO
			GOTO BACKUP_TO
		)
		IF [%ACCOUNT_PASSWORD%] == [] (
			SET ERROR=MOVE_BACKUP = true so, ACCOUNT_PASSWORD
			GOTO ERROR
		)
	)
	IF "%PATH_TO_SQL_BACKUP%" == "changeme" (
		SET ERROR=PATH_TO_SQL_BACKUP
		GOTO PATH_TO_SQL_BACKUP
	)
	IF [%PATH_TO_SQL_BACKUP%] == [] (
		SET ERROR=BACKUP = true so, PATH_TO_SQL_BACKUP
		GOTO ERROR
	)
)

SET T_NAME=IMAGENAME eq %EXE%

ECHO.
ECHO MESSAGE: Variable checks completed!
SET LOOPS=0

:LOOP
TASKLIST /FI "%T_NAME%" 2>NUL | find /I /N "%PORT%">NUL
IF "%ERRORLEVEL%" == "0" GOTO LOOP

ECHO.
ECHO MESSAGE: Pre startup complete!
ECHO MESSAGE: Starting server at: %DATE%, %TIME%
IF "%LOOPS%" NEQ "0" (
	ECHO MESSAGE: Restarts: %LOOPS%
)

:: Uses https://www.redolive.com/utah-web-designers-blog/automated-mysql-backup-for-windows
IF "%BACKUP%" == "true" (
	ECHO MESSAGE: Starting Database Backup
	START /wait %PATH_TO_SQL_BACKUP%
	IF "%MOVE_BACKUP%" == "true" (
		MOVE /wait /-Y  "%BACKUP_FROM%"*.* "%BACKUP_TO%"
	)
	ECHO MESSAGE: Database backup complete
)

IF "%USE_STEAM_UPDATER%" == "true" (
	ECHO MESSAGE: Steam Automatic Update Starting
	CD %PATH_TO_STEAM_CMD_EXE%
	START /wait "SteamCMD.exe" +login %ACCOUNT_NAME% %ACCOUNT_PASSWORD% +force_install_dir %EXE_PATH% +app_update 223350 %ADDITIONAL_ITEMS% validate +quit
	ECHO MESSAGE: Steam Automatic Update Completed
)

:: Start the DayZ Server
CD %EXE_PATH%
START "%S_NAME%" /wait %EXE% -mod=%MODLIST% -config=%CONFIG% -profiles=%PROFILE% -port=%PORT% -serverMod=%SERVERMODLIST% %ADDITIONAL_PARAMETERS%
ECHO MESSAGE: To stop the server, close %~nx0 then the other tasks, otherwise it will restart

IF "%USE_DZSAL_MODSERVER%" == "true" (
    ECHO MESSAGE: Starting Mod Server
    START "%S_NAME%'s Mod Server" /wait %EXE_DZSAL% %DZSAL_PARAMETERS%
)
ECHO.
GOTO LOOPING

:: Monitoring Loop
:LOOP
ECHO WARNING: Server is already running, running monitoring loop

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
