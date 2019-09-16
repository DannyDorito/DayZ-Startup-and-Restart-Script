# DayZ Startup & Restart Script

Originally created for the ARMA 3 Exile Mod, now adapted for DayZ Servers!

This is .bat file for **all** your DayZ Server startup needs!

Created by: **Jstrow** and **DannyDorito** originally for [CSG Exile](https://www.csgcommunity.com)
Contributor: **NIXON** [NIXON](https://github.com/niklashenrixon)

Forking this repo will be public, **do not** put sensitive information such as passwords into your **public** repo.
A better alternative is a private repo, which GitHub now offers free for all users, so download a copy of this one and create your own!

Click [Here](https://github.com/DannyDorito/ARMA-3-Startup-and-Restart-Script) for the ARMA 3 Version!

## Check out our Twitter

[@JohnAllis0n](https://twitter.com/JohnAllis0n)

[@CSG_Exile](https://twitter.com/CSG_Exile)

## Features

* Server startup - parameters
* Crash/Restart monitor - this uses the Task Manager and not address pinging
* The last start date & time of the server
* Optional DayZ Standalone Launcher mod download server - Allows players to download mods through the DayZ SA Launcher

## Features to be added

* Optional Features from the ARMA 3 Version!

## FAQ

### How do I use this

1. Forking this repo will be public, **do not** put sensitive information such as passwords into your **public** repo. A better alternative is a private repo, which GitHub now offers free for all users, so download a copy of this one and create your own!
2. Download the latest version
3. Place in a suitable directory, for example your Desktop
4. Replace all of the variables that you require, e.g. ![set path_to_ServervarsArma3Profile=changeme](https://i.imgur.com/svri9W0.png) to: ![set path_to_ServervarsArma3Profile=C:\arma\CSG\Users\CSG\CSG.vars.Arma3Profile](https://i.imgur.com/p27kTKK.png)
5. Enabling some features, for example to enable Steam auto updates find: ![set use_steam_updater=false](https://i.imgur.com/dnlZHqs.png) and change it to: ![set use_steam_updater=true](https://i.imgur.com/7OPRUDR.png) Some features require more variables to be set, if unsure run the ``DayZServerStart.bat`` file and see if there are any errors **if so**, repeat step 3 and 4.
6. Run the ``DayZServerStart.bat`` fill and see if there are any errors, **if so**, repeat step 3 and 4.
7. To shutdown the server, close the console window first (and all other windows), **then** shutdown the server or it will automatically restart.
