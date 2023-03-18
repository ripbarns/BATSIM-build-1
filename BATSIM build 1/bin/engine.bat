:top

	:start
		set temp=0
		for /f "tokens=*" %%a in (blocks.txt) do (
			set block_!temp!=%%a
			set /a temp=!temp! + 1
		)

		call nls.bat
		if !game_mode! equ multiplayer cd /d "%~dp0"
		call !game_mode!.bat