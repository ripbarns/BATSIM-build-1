:top

	:start
		echo off
		setlocal enabledelayedexpansion

		cd "%~dp0"\bin

		< "settings.txt" (
			set /p color_mode=
			set /p color=
		)

		set build=1
		set space=space space

		title BATSIM build !build!
		color !color!
		mode 109,31

		goto :menu

	:debug
		cls
		echo [3;2HBATSIM build !build! - Debug

		set /p debug=Debug: 
			!debug!

		goto :debug

	:menu
		cls
		echo [3;2HBATSIM build !build!
		echo [5;2H1. Singleplayer
		echo [6;2H2. Multiplayer
		echo [7;2H3. Information
		echo [8;2H4. Settings
		echo [10;2H6. Exit

		choice /c 123468 /n
			if !errorlevel! equ 1 goto :singleplayer
			if !errorlevel! equ 2 goto :multiplayer
			if !errorlevel! equ 3 goto :info
			if !errorlevel! equ 4 goto :settings
			if !errorlevel! equ 5 exit
			if !errorlevel! equ 6 goto :debug

	:info
		cls
		echo [3;2HBATSIM build !build! - Information
		echo [5;2HCreated by @ripbarns on all major social media.
		echo [7;2HPress any key to continue.

		pause > nul
			goto :menu

	:settings
		cls
		echo [3;2HBATSIM build !build! - Settings
		echo [5;2H1. Toggle light and dark mode [!color_mode!]
		echo [7;2H3. Back

		choice /c 13 /n
			if !errorlevel! equ 1 goto :settings_color
			if !errorlevel! equ 2 goto :menu

		:settings_save
			(
				echo !color_mode!
				echo !color!
			) > "settings.txt"

			goto :settings

		:settings_color
			if !color_mode! equ dark (
				set color_mode=light
				set color=f0
			) else (
				set color_mode=dark
				set color=0f
			)

			color !color!

			goto :settings_save

	:singleplayer
		cls
		echo [3;2HBATSIM build !build! - Singleplayer
		echo [5;2H1. Continue
		echo [6;2H2. New
		echo [8;2H4. Back

		choice /c 124 /n
			if !errorlevel! equ 1 goto :singleplayer_load
			if !errorlevel! equ 2 goto :singleplayer_new
			if !errorlevel! equ 3 goto :menu

		:singleplayer_new
			if exist "save.txt" goto :singleplayer_new_overwrite
			if exist "world.txt" goto :singleplayer_new_overwrite

			set nls=new
			set game_mode=singleplayer

			goto :engine

			:singleplayer_new_overwrite
				cls
				echo [3;2HThere is already an existing world.
				echo [5;2HIf you start a new world, your old world will be deleted.
				echo [7;2HWould you like to delete your world?
				echo [9;2H1. Yes
				echo [10;2H2. No

				choice /c 12 /n
					if !errorlevel! equ 1 (
						if exist "save.txt" del "save.txt"
						if exist "world.txt" del "world.txt"
						goto :singleplayer_new
					)
					if !errorlevel! equ 2 goto :menu

		:singleplayer_load
			if not exist "save.txt" goto :singleplayer_load_fail
			if not exist "world.txt" goto :singleplayer_load_fail

			set nls=load
			set game_mode=singleplayer

			goto :engine

			:singleplayer_load_fail
				cls
				echo [3;2HThere was an error loading your world.
				echo [5;2HPlease start a new world.
				echo [7;2HPress any key to continue.

				pause > nul
					if exist "save.txt" del "save.txt"
					if exist "world.txt" del "world.txt"

					goto :menu

	:multiplayer
		cls
		echo [3;2HBATSIM build !build! - Multiplayer
		echo [5;2H1. Join World
		echo [6;2H2. Create World
		echo [8;2H4. Back

		choice /c 124 /n
			if !errorlevel! equ 1 goto :multiplayer_join
			if !errorlevel! equ 2 goto :multiplayer_create
			if !errorlevel! equ 3 goto :menu

		:multiplayer_join
			cls
			echo [3;2HType "back" to go back.

			set /p player1=Enter your character: 
				if !player1! equ back goto :menu
				set player1=!player1:~0,1!

			set /p player2=Enter the other players character: 
				if !player2! equ back goto :menu
				set player2=!player2:~0,1!

			set nls=load_world
			set game_mode=multiplayer

			cd /d c:\users\!username!\dropbox
			< "!player1!.txt" (
				set /p x=
				set /p y=
			)
			cd /d "%~dp0"\bin

			goto :engine

		:multiplayer_create
			cls
			echo [3;2HType "back" to go back.

			set /p player1=Enter your character: 
				if !player1! equ back goto :menu
				set player1=!player1:~0,1!

			set /p player2=Enter the other players character: 
				if !player2! equ back goto :menu
				set player2=!player2:~0,1!

			set nls=new
			set game_mode=multiplayer

			cd /d c:\users\!username!\dropbox
			(
				echo 50
				echo 50
			) > "!player2!.txt"
			cd /d "%~dp0"\bin

			goto :engine

	:engine
		call engine.bat