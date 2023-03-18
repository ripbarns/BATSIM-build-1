:top

	:start
		goto :!nls!

	:new

		:new_save
			cls
			echo [3;2HCreating world...

			rem set x=50
			rem set y=50

			set money=0
			set flower=0
			set wood=0
			set stone=0

			set nls=save

		:new_world
			call generator.bat

			set x=50
			set y=50

			goto :load_world

	:load

		:load_save
			cls
			echo [3;2HLoading world...

			< save.txt (
				set /p x=
				set /p y=
				set /p money=
				set /p flower=
				set /p wood=
				set /p stone=
			)

		:load_world
			if !game_mode! equ multiplayer cd /d c:\users\!username!\dropbox

			set temp=0
			for /f "tokens=*" %%a in (world.txt) do (
				set line_!temp!=%%a
				set /a temp=!temp! + 1
			)

			set nls=save

			exit /b

	:save

		:save_check
			if exist "save.txt" goto :save_overwrite
			if exist "world.txt" goto :save_overwrite

		:save_overwrite
			cls
			echo [3;2HWould you like to overwrite the existing save file?
			echo [5;2H1. Yes
			echo [6;2H2. No

			choice /c 12 /n
				if !errorlevel! equ 1 goto :save_save
				if !errorlevel! equ 2 exit /b

		:save_save
			cls
			echo [3;2HSaving world...

			(
				echo !x!
				echo !y!
				echo !money!
				echo !flower!
				echo !wood!
				echo !stone!
			) > save.txt

		:save_world
			if exist "world.txt" del "world.txt"

			for /l %%a in (0,1,100) do (
				echo !line_%%a!>>world.txt
			)

			exit /b