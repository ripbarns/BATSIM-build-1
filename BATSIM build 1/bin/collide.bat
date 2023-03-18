:top

	:start
		set /a v=!x! + 1

		for /l %%a in (0,1,6) do (
			if "!line_%y%:~%x%,1!" equ "!block_%%a:~0,1!" goto :block_!block_%%a:~2!
		)

		exit /b

	:block

		:block_clear
			if !errorlevel! equ 1 set line_!y!=!line_%y%:~0,%x%!!space:~5,1!!line_%y%:~%z%!
			if !errorlevel! equ 2 set line_!y!=!line_%y%:~0,%x%!!space:~5,1!!line_%y%:~%v%!
			if !errorlevel! equ 3 set line_!y!=!line_%y%:~0,%x%!!space:~5,1!!line_%y%:~%z%!
			if !errorlevel! equ 4 set line_!y!=!line_%y%:~0,%x%!!space:~5,1!!line_%y%:~%v%!

			exit /b

		:block_back
			if !errorlevel! equ 1 set /a y=!y! + 1
			if !errorlevel! equ 2 set /a x=!x! + 1
			if !errorlevel! equ 3 set /a y=!y! - 1
			if !errorlevel! equ 4 set /a x=!x! - 1

			exit /b

		:block_wall
			goto :block_back

		:block_money
			set /a money=!money! + 1

			goto :block_clear
		:block_flower
			set /a flower=!flower! + 1

			goto :block_clear
		:block_wood
			set /a wood=!wood! + 1

			goto :block_clear
		:block_stone
			set /a stone=!stone! + 1

			goto :block_clear
		:block_water
			goto :block_back

		:block_itemshop
			cls
			echo [3;2HHello, welcome to the item shop.
			echo [5;2HWould you like to buy or sell?
			echo [7;2HMoney: [!money!]
			echo [9;2H1. Buy
			echo [10;2H2. Sell
			echo [12;2H4. Back

			choice /c 412 /n
				if !errorlevel! equ 2 goto :block_itemshop_buy
				if !errorlevel! equ 3 goto :block_itemshop_sell
				if !errorlevel! equ 1 (
					cls
					goto :block_back
				)

			:block_itemshop_buy
				cls
				echo [3;2HSure thing, buddy.
				echo [5;2HWhatcha wanna buy today?
				echo [7;2HMoney: [!money!]
				echo [9;2H1. Flower [1]
				echo [10;2H2. Wood [2]
				echo [11;2H3. Stone [3]
				echo [13;2H5. Back

				choice /c 1235 /n
					if !errorlevel! equ 1 goto :block_itemshop_buy_flower
					if !errorlevel! equ 2 goto :block_itemshop_buy_wood
					if !errorlevel! equ 3 goto :block_itemshop_buy_stone
					if !errorlevel! equ 4 goto :block_itemshop

				:block_itemshop_buy_fail
					cls
					echo [3;2HOof. Looks like you're a bit short with your money there.
					echo [5;2HI won't be able to sell this to you right now.
					echo [7;2HPress any key to continue.

					pause > nul
						goto :block_itemshop_buy

				:block_itemshop_buy_flower
					if !money! lss 1 goto :block_itemshop_buy_fail

					set /a money=!money! - 1
					set /a flower=!flower! + 1

					goto :block_itemshop_buy

				:block_itemshop_buy_wood
					if !money! lss 2 goto :block_itemshop_buy_fail

					set /a money=!money! - 2
					set /a wood=!wood! + 1

					goto :block_itemshop_buy

				:block_itemshop_buy_stone
					if !money! lss 3 goto :block_itemshop_buy_fail

					set /a money=!money! - 3
					set /a stone=!stone! + 1

					goto :block_itemshop_buy

			:block_itemshop_sell
				cls
				echo [3;2HSure thing, buddy.
				echo [5;2HWhatcha wanna sell today?
				echo [7;2HMoney: [!money!]
				echo [9;2H1. Flower [1]
				echo [10;2H2. Wood [2]
				echo [11;2H3. Stone [3]
				echo [13;2H5. Back

				choice /c 1235 /n
					if !errorlevel! equ 1 goto :block_itemshop_sell_flower
					if !errorlevel! equ 2 goto :block_itemshop_sell_wood
					if !errorlevel! equ 3 goto :block_itemshop_sell_stone
					if !errorlevel! equ 4 goto :block_itemshop

				:block_itemshop_sell_fail
					cls
					echo [3;2HOof. Looks like you're a bit short with your items there.
					echo [5;2HI won't be able to buy that from you right now.
					echo [7;2HPress any key to continue.

					pause > nul
						goto :block_itemshop_sell

				:block_itemshop_sell_flower
					if !flower! lss 1 goto :block_itemshop_sell_fail

					set /a money=!money! + 1
					set /a flower=!flower! - 1

					goto :block_itemshop_sell

				:block_itemshop_sell_wood
					if !wood! lss 1 goto :block_itemshop_sell_fail

					set /a money=!money! + 2
					set /a wood=!wood! - 1

					goto :block_itemshop_sell

				:block_itemshop_sell_stone
					if !stone! lss 1 goto :block_itemshop_sell_fail

					set /a money=!money! + 3
					set /a stone=!stone! - 1

					goto :block_itemshop_sell