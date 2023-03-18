:top

	:start
		cls
		goto :position_load

	:loop
		cls

		:position

			:position_save
				cd /d c:\users\!username!\dropbox
				(
					echo !x!
					echo !y!
				) > "!player1!.txt"

			:position_load
				cd /d c:\users\!username!\dropbox
				< "!player2!.txt" (
					set /p player2_x=
					set /p player2_y=
				)

				goto :refresh

		:refresh
			for /l %%a in (0,1,100) do (
				set line_temp_%%a=!line_%%a!
			)

			set /a w=!x! - 37
			set /a z=!x! + 1

			set /a player2_z=!player2_x! + 1

			for /l %%a in (0,1,11) do (
				set /a u%%a=!y! - %%a - 1
				set /a d%%a=!y! + %%a + 1
			)

			set line_temp_!player2_y!=!line_%player2_y%:~0,%player2_x%!!player2!!line_%player2_y%:~%player2_z%!

		:screen
			echo [3;2H###########################################################################################################
			echo [4;2H# !line_temp_%u11%:~%w%,75! #                           #
			echo [5;2H# !line_temp_%u10%:~%w%,75! #                           #
			echo [6;2H# !line_temp_%u9%:~%w%,75! #                           #
			echo [7;2H# !line_temp_%u8%:~%w%,75! #                           #
			echo [8;2H# !line_temp_%u7%:~%w%,75! #                           #
			echo [9;2H# !line_temp_%u6%:~%w%,75! #                           #
			echo [10;2H# !line_temp_%u5%:~%w%,75! #                           #
			echo [11;2H# !line_temp_%u4%:~%w%,75! #                           #
			echo [12;2H# !line_temp_%u3%:~%w%,75! #                           #
			echo [13;2H# !line_temp_%u2%:~%w%,75! #                           #
			echo [14;2H# !line_temp_%u1%:~%w%,75! #                           #
			echo [15;2H# !line_temp_%u0%:~%w%,75! #                           #
			echo [16;2H# !line_temp_%y%:~%w%,37!!line_temp_%y%:~%z%,37! #                           #
			echo [17;2H# !line_temp_%d0%:~%w%,75! #                           #
			echo [18;2H# !line_temp_%d1%:~%w%,75! #                           #
			echo [19;2H# !line_temp_%d2%:~%w%,75! #                           #
			echo [20;2H# !line_temp_%d3%:~%w%,75! #                           #
			echo [21;2H# !line_temp_%d4%:~%w%,75! #                           #
			echo [22;2H# !line_temp_%d5%:~%w%,75! #                           #
			echo [23;2H# !line_temp_%d6%:~%w%,75! #                           #
			echo [24;2H# !line_temp_%d7%:~%w%,75! #                           #
			echo [25;2H# !line_temp_%d8%:~%w%,75! #                           #
			echo [26;2H# !line_temp_%d9%:~%w%,75! #                           #
			echo [27;2H# !line_temp_%d10%:~%w%,75! #                           #
			echo [28;2H# !line_temp_%d11%:~%w%,75! #                           #
			echo [29;2H###########################################################################################################

			echo [25;82H!player1!-!player2!
			echo [26;82H[M] Exit
			echo [28;82H(!x!,!y!) [!line_%y%:~%x%,1!]

			choice /c wasdmx /t 1 /d x /n
				if !errorlevel! leq 4 goto :move
				if !errorlevel! equ 5 exit
				if !errorlevel! equ 6 goto :position

		:move
			if !errorlevel! equ 1 set /a y=!y! - 1
			if !errorlevel! equ 2 set /a x=!x! - 1
			if !errorlevel! equ 3 set /a y=!y! + 1
			if !errorlevel! equ 4 set /a x=!x! + 1

			if "!line_%y%:~%x%,1!" neq " " (
				cd /d "%~dp0"
				call collide.bat
			)

			goto :position