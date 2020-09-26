library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
USE  IEEE.STD_LOGIC_ARITH.all;


entity test is
port(mode : in std_logic_vector(2 downto 0);
		Health_Bar : in std_logic_vector(3 downto 0);	
		score0 : in std_logic_vector(5 downto 0);
		score1 : in std_logic_vector(5 downto 0);
		level	 : in std_logic_vector(2 downto 0);
		pixel_row : in std_logic_vector(9 downto 0);
		pixel_column : in std_logic_vector(9 downto 0);
		character_address : out std_logic_vector(5 downto 0);
		text_row: out std_logic_vector(2 downto 0);
		text_column: out std_logic_vector(2 downto 0)) ;
end entity test;

architecture behaviour of test is
begin
	---------------------------------------------------------------- Character address ---------------------------------------------------------------------------------------------------------------------------------------------------------------

	character_address <= 
	---------------------------------------------------------------- Main Menu -------------------------------------------------
		-- Left Click Training
		"001100" when pixel_column > 32 and pixel_column < 48 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- L
		"000101" when pixel_column > 48 and pixel_column < 64 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- E
		"000110" when pixel_column > 64 and pixel_column < 80 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- F
		"010100" when pixel_column > 80 and pixel_column < 96 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- T
		"000011" when pixel_column > 96  and pixel_column < 112 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- C
		"001100" when pixel_column > 112 and pixel_column < 128 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- L
		"001001" when pixel_column > 128 and pixel_column < 144 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- I
		"000011" when pixel_column > 144 and pixel_column < 160 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- C
		"001011" when pixel_column > 160 and pixel_column < 176 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- K
		"101101" when pixel_column > 176 and pixel_column < 192 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- '-'
		"010100" when pixel_column > 192 and pixel_column < 208 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- T
		"010010" when pixel_column > 208 and pixel_column < 224 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- R
		"000001" when pixel_column > 224 and pixel_column < 240 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- A
		"001001" when pixel_column > 240 and pixel_column < 256 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- I
		"001110" when pixel_column > 256 and pixel_column < 272 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- N
		"001001" when pixel_column > 272 and pixel_column < 288 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- I
		"001110" when pixel_column > 288 and pixel_column < 304 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- N
		"000111" when pixel_column > 304 and pixel_column < 320 and pixel_row > 32 and pixel_row < 48 and mode = "000" else -- G
		--Right Click GameMode
		"010010" when pixel_column > 32 and pixel_column < 48 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- R
		"001001" when pixel_column > 48 and pixel_column < 64 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- I
		"000111" when pixel_column > 64 and pixel_column < 80 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- G
		"001000" when pixel_column > 80 and pixel_column < 96 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- H
		"010100" when pixel_column > 96 and pixel_column < 112 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- T
		"000011" when pixel_column > 112 and pixel_column < 128 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- C
		"001100" when pixel_column > 128 and pixel_column < 144 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- L
		"001001" when pixel_column > 144 and pixel_column < 160 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- I
		"000011" when pixel_column > 160 and pixel_column < 176 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- C
		"001011" when pixel_column > 176 and pixel_column < 192 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- K
		"101101" when pixel_column > 192 and pixel_column < 208 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- '-'
		"000111" when pixel_column > 208 and pixel_column < 224 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- G
		"000001" when pixel_column > 224 and pixel_column < 240 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- A
		"001101" when pixel_column > 240 and pixel_column < 256 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- M
		"000101" when pixel_column > 256 and pixel_column < 272 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- E
		"001101" when pixel_column > 272 and pixel_column < 288 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- M
		"001111" when pixel_column > 288 and pixel_column < 304 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- O
		"000100" when pixel_column > 304 and pixel_column < 320 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- D
		"000101" when pixel_column > 320 and pixel_column < 336 and pixel_row > 64 and pixel_row < 80 and mode = "000" else -- E
		-- FlappyBird
		"000110" when pixel_column > 224 and pixel_column < 256 and pixel_row > 224 and pixel_row < 256 and mode = "000" else -- F
		"001100" when pixel_column > 256 and pixel_column < 288 and pixel_row > 224 and pixel_row < 256 and mode = "000" else -- L
		"000001" when pixel_column > 288 and pixel_column < 320 and pixel_row > 224 and pixel_row < 256 and mode = "000" else -- A
		"010000" when pixel_column > 320 and pixel_column < 384 and pixel_row > 224 and pixel_row < 256 and mode = "000" else -- P x2
		"011001" when pixel_column > 384 and pixel_column < 416 and pixel_row > 224 and pixel_row < 256 and mode = "000" else -- 		
	---------------------------------------------------------------- Main Menu -------------------------------------------------

	
		---------------------------------------------------------------- InGame -------------------------------------------------
		-- level
		"001100" when pixel_column > 32 and pixel_column < 48 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- L
		"000101" when pixel_column > 48 and pixel_column < 64 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- E
		"010110" when pixel_column > 64 and pixel_column < 80 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- V
		"000101" when pixel_column > 80 and pixel_column < 96 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- E
		"001100" when pixel_column > 96 and pixel_column < 112 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- L
		"101101" when pixel_column > 112 and pixel_column < 128 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- '-'
 "110" & (level - 1)  when pixel_column > 128 and pixel_column < 144 and pixel_row > 32 and pixel_row < 48 and mode > 0 else -- level
		-- score
		"010011" when pixel_column > 32 and pixel_column < 48 and pixel_row > 64 and pixel_row < 80 and  mode > 0 else -- S
		"000011" when pixel_column > 48 and pixel_column < 64 and pixel_row > 64 and pixel_row < 80 and  mode > 0 else -- C
		"001111" when pixel_column > 64 and pixel_column < 80 and pixel_row > 64 and pixel_row < 80 and  mode > 0 else -- O
		"010010" when pixel_column > 80 and pixel_column < 96 and pixel_row > 64 and pixel_row < 80 and  mode > 0 else -- R
		"000101" when pixel_column > 96 and pixel_column < 112 and pixel_row > 64 and pixel_row < 80 and mode > 0 else -- E
		"101101" when pixel_column > 112 and pixel_column < 128 and pixel_row > 64 and pixel_row < 80 and mode > 0 else -- '-'	
		  score1 when pixel_column > 128 and pixel_column < 144 and pixel_row > 64 and pixel_row < 80 and mode > 0 else -- score1
		  score0 when pixel_column > 144 and pixel_column < 160 and pixel_row > 64 and pixel_row < 80 and mode > 0 else -- score0
		 -- Health
		"001000" when pixel_column > 32 and pixel_column < 48 and pixel_row > 96 and pixel_row < 112 and  mode > 0 else -- H
		"000101" when pixel_column > 48 and pixel_column < 64 and pixel_row > 96 and pixel_row < 112 and  mode > 0 else -- E
		"000001" when pixel_column > 64 and pixel_column < 80 and pixel_row > 96 and pixel_row < 112 and  mode > 0 else -- A
		"001100" when pixel_column > 80 and pixel_column < 96 and pixel_row > 96 and pixel_row < 112 and  mode > 0 else -- L
		"010100" when pixel_column > 96 and pixel_column < 112 and pixel_row > 96 and pixel_row < 112 and mode > 0 else -- T
		"001000" when pixel_column > 112 and pixel_column < 128 and pixel_row > 96 and pixel_row < 112 and mode > 0 else -- H	
		"101101" when pixel_column > 128 and pixel_column < 144 and pixel_row > 96 and pixel_row < 112 and mode > 0 else -- '-'	
		"11" & Health_Bar when pixel_column > 144 and pixel_column < 160 and pixel_row > 96 and pixel_row < 112 and mode > 0 else -- Health Bar
		---------------------------------------------------------------- InGame -------------------------------------------------
		  
		---------------------------------------------------------------- GameOver -------------------------------------------------
		-- GameOver!
		"000111" when pixel_column > 192 and pixel_column < 224 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- G
		"000001" when pixel_column > 224 and pixel_column < 256 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- A
		"001101" when pixel_column > 256 and pixel_column < 288 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- M
		"000101" when pixel_column > 288 and pixel_column < 320 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- E 
		"001111" when pixel_column > 320 and pixel_column < 352 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- O	
		"010110" when pixel_column > 352 and pixel_column < 384 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- V
		"000101" when pixel_column > 384 and pixel_column < 416 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- E	
		"010010" when pixel_column > 416 and pixel_column < 448 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- R
		"100001" when pixel_column > 448 and pixel_column < 480 and pixel_row > 224 and pixel_row < 256 and mode = "111" else -- !
--		-- Press any to restart
		"010000" when pixel_column > 192 and pixel_column < 208 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- P
		"010010" when pixel_column > 208 and pixel_column < 224 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- R
		"000101" when pixel_column > 224 and pixel_column < 240 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- E
		"010011" when pixel_column > 240 and pixel_column < 272 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- S x2
		"100000" when pixel_column > 272 and pixel_column < 288 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- space
		"000001" when pixel_column > 288 and pixel_column < 304 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- A
		"001110" when pixel_column > 304 and pixel_column < 320 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- N	
		"011001" when pixel_column > 320 and pixel_column < 336 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- Y
		"100000" when pixel_column > 336 and pixel_column < 352 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- space
		"010100" when pixel_column > 352 and pixel_column < 368 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- T
		"001111" when pixel_column > 368 and pixel_column < 384 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- O
		"100000" when pixel_column > 384 and pixel_column < 400 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- space
		"010010" when pixel_column > 400 and pixel_column < 416 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- R
		"000101" when pixel_column > 416 and pixel_column < 432 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- E
		"010011" when pixel_column > 432 and pixel_column < 448 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- S
		"010100" when pixel_column > 448 and pixel_column < 464 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- T
		"000001" when pixel_column > 464 and pixel_column < 480 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- A	
		"010010" when pixel_column > 480 and pixel_column < 496 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- R
		"010100" when pixel_column > 496 and pixel_column < 512 and pixel_row > 272 and pixel_row < 288 and mode = "111" else -- T	
		---------------------------------------------------------------- GameOver -------------------------------------------------
		
		---------------------------------------------------------------- Win -----------------------------------------------------
		-- Win
		"010111" when pixel_column > 256 and pixel_column < 288 and pixel_row > 224 and pixel_row < 256 and mode = "110" else -- W
		"001001" when pixel_column > 288 and pixel_column < 320 and pixel_row > 224 and pixel_row < 256 and mode = "110" else -- I
		"001110" when pixel_column > 320 and pixel_column < 352 and pixel_row > 224 and pixel_row < 256 and mode = "110" else -- N
		"100001" when pixel_column > 352 and pixel_column < 384 and pixel_row > 224 and pixel_row < 256 and mode = "110" else -- !
		---------------------------------------------------------------- Win -----------------------------------------------------
		null;

	---------------------------------------------------------------- Character address ---------------------------------------------------------------------------------------------------------------------------------------------------------------

	
	
	
	
	---------------------------------------------------------------- Row ---------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	text_row <= 
	---------------------------------------------------------------- Main Menu ----------------------------------------------------------
--	-- FlappyBird
	pixel_row(4 downto 2) when (pixel_row > 224 and pixel_row < 256 and pixel_column > 224 and pixel_column < 416 and mode = "000") else
	-- Left Click Training
	pixel_row(3 downto 1) when (pixel_row > 32 and pixel_row < 48 and pixel_column > 32 and pixel_column < 320 and mode = 0) else 
	-- Right Click GameMode
	pixel_row(3 downto 1) when (pixel_row > 64 and pixel_row < 80 and pixel_column > 32 and pixel_column < 336 and mode = 0) else 
	---------------------------------------------------------------- Main Menu ----------------------------------------------------------
	
	---------------------------------------------------------------- InGame -------------------------------------------------------
	-- level
	pixel_row(3 downto 1) when (pixel_row > 32 and pixel_row < 48 and pixel_column > 32 and pixel_column < 144 and mode > 0) else 
	-- Score
	pixel_row(3 downto 1) when (pixel_row > 64 and pixel_row < 80 and pixel_column > 32 and pixel_column < 160 and mode > 0) else 
	-- Health bar
	pixel_row(3 downto 1) when (pixel_row > 96 and pixel_row < 112 and pixel_column > 32 and pixel_column < 160 and mode > 0) else 
	---------------------------------------------------------------- InGame --------------------------------------------------------
	
	---------------------------------------------------------------- GameOver ----------------------------------------------------------
	-- GameOver!
	pixel_row(4 downto 2) when (pixel_row > 224 and pixel_row < 256 and pixel_column > 192 and pixel_column < 480 and mode = "111") else 
	-- Press any to restart
	pixel_row(3 downto 1) when (pixel_row > 272 and pixel_row < 288 and pixel_column > 192 and pixel_column < 512 and mode = "111") else 
	---------------------------------------------------------------- GameOver -----------------------------------------------------------
	
	---------------------------------------------------------------- Win --------------------------------------------------------------------
	-- Win
	pixel_row(4 downto 2) when (pixel_row > 224 and pixel_row < 256 and pixel_column > 256 and pixel_column < 384 and mode = "110" ) else "111";
	---------------------------------------------------------------- Win -------------------------------------------------------------------

	---------------------------------------------------------------- Row --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
	
	
	
	---------------------------------------------------------------- Column ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	text_column <= 
	---------------------------------------------------------------- Main Menu ------------------------------------------------------------
--	-- FlappyBird
	pixel_column(4 downto 2) when (pixel_row > 224 and pixel_row < 256 and pixel_column > 224 and pixel_column < 416 and mode = "000") else
	-- Left Click Training
	pixel_column(3 downto 1) when (pixel_row > 32 and pixel_row < 48 and pixel_column > 32 and pixel_column < 320 and mode = 0) else 
	-- Right Click GameMode
	pixel_column(3 downto 1) when (pixel_row > 64 and pixel_row < 80 and pixel_column > 32 and pixel_column < 336 and mode = 0) else 
	---------------------------------------------------------------- Main Menu ------------------------------------------------------------
	
	---------------------------------------------------------------- InGame ---------------------------------------------------------
	-- level
	pixel_column(3 downto 1) when (pixel_row > 32 and pixel_row < 48 and pixel_column > 32 and pixel_column < 144 and mode > 0) else 
	-- Score
	pixel_column(3 downto 1) when (pixel_row > 64 and pixel_row < 80 and pixel_column > 32 and pixel_column < 160 and mode > 0) else 
	-- Health bar
	pixel_column(3 downto 1) when (pixel_row > 96 and pixel_row < 112 and pixel_column > 32 and pixel_column < 160 and mode > 0) else 
	---------------------------------------------------------------- InGame --------------------------------------------------------
	
	---------------------------------------------------------------- GameOver -------------------------------------------------------------------
	-- GameOver!
	pixel_column(4 downto 2) when (pixel_row > 224 and pixel_row < 256 and pixel_column > 192 and pixel_column < 480 and mode = "111") else 
	-- Press any to restart
	pixel_column(3 downto 1) when (pixel_row > 272 and pixel_row < 288 and pixel_column > 192 and pixel_column < 512 and mode = "111") else 
		
	---------------------------------------------------------------- GameOver -------------------------------------------------------------------
			
	---------------------------------------------------------------- Win ---------------------------------------------------------------------
	-- Win
	pixel_column(4 downto 2) when (pixel_row > 224 and pixel_row < 256 and pixel_column > 256 and pixel_column < 384 and mode = "110") else "111";
	---------------------------------------------------------------- Win ----------------------------------------------------------------------
	
	---------------------------------------------------------------- Column ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

end architecture behaviour;

















