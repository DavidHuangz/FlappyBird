library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity display_selector is
port(mode : in std_logic_vector(2 downto 0);
		bird : in std_logic;
		pipe_1 : in std_logic;
		pipe_2 : in std_logic;
		pipe_3 : in std_logic;
		text_data : in std_logic;
		pixel_row : in std_logic_vector(9 downto 0);
		pixel_column : in std_logic_vector(9 downto 0);
		score0 		: in std_logic_vector(5 downto 0);	
		score1 		: in std_logic_vector(5 downto 0);
		red : out std_logic;
		green : out std_logic;
		blue : out std_logic);
end entity display_selector;

architecture behaviour of display_selector is
begin
	red <= text_data when text_data = '1' and mode = "110" else -- Win screen
		text_data when text_data = '1' and mode = "111" else -- Game Over
		text_data when text_data = '1' and mode > 0 else -- GameMode
		
		bird when bird = '1' and mode > 0 else -- bird priority display		
		
		-- pink pipes for lvl 2 -----------------------------------------
		pipe_1 when pipe_1 = '1' and mode = "011" else -- Green for others
		pipe_2 when pipe_2 = '1' and mode = "011" else -- Green for others
		pipe_3 when pipe_3 = '1' and mode = "011" else -- Green for others
		------------------------------------------------------------------
		
		-- Red pipes for lvl 3 -----------------------------------------
		pipe_1 when pipe_1 = '1' and mode = "100" else -- Green for others
		pipe_2 when pipe_2 = '1' and mode = "100" else -- Green for others
		pipe_3 when pipe_3 = '1' and mode = "100" else -- Green for others
		------------------------------------------------------------------
		
		-- Pipes for others -----------------------------------------------------------------------------------------------------------
		not pipe_1 when pipe_1 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		not pipe_2 when pipe_2 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		not pipe_3 when pipe_3 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		------------------------------------------------------------------------------------------------------------------------------


		not text_data when mode = "000" and pixel_row > 30 and pixel_row < 48 else
		text_data when mode = "000" and pixel_row > 62 and pixel_row < 80 else
		text_data when mode = "000" and pixel_row > 222 and pixel_row < 256 and pixel_column > 222 and pixel_column < 416 and text_data = '1' else
		
		not text_data when (score0 = 53 and mode = "100") else -- Make background blue so bird is invisible every 5 pipes for lvl 3
		
		text_data;
	green <= --text_data when text_data = '1' and mode = "110" else -- Win screen
		text_data when text_data = '1' and mode = "111" else -- Game Over
		text_data when text_data = '1' and mode > 0 else -- GameMode
		bird when bird = '1' and mode > 0  else
		
		-- pink pipes for lvl 2 -----------------------------------------
		not pipe_1 when pipe_1 = '1' and mode = "011" else -- Green for others
		not pipe_2 when pipe_2 = '1' and mode = "011" else -- Green for others
		not pipe_3 when pipe_3 = '1' and mode = "011" else -- Green for others
		------------------------------------------------------------------
		
		-- Red pipes for lvl 3 -----------------------------------------
		not pipe_1 when pipe_1 = '1' and mode = "100" else -- Green for others
		not pipe_2 when pipe_2 = '1' and mode = "100" else -- Green for others
		not pipe_3 when pipe_3 = '1' and mode = "100" else -- Green for others
		------------------------------------------------------------------
		
		-- Pipes for others -----------------------------------------------------------------------------------------------------------
		 pipe_1 when pipe_1 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		 pipe_2 when pipe_2 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		 pipe_3 when pipe_3 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		------------------------------------------------------------------------------------------------------------------------------
		
		not text_data when mode = "000" and pixel_row > 30 and pixel_row < 48 else
		not text_data when mode = "000" and pixel_row > 62 and pixel_row < 80 else
		text_data when mode = "000" and pixel_row > 222 and pixel_row < 256 and pixel_column > 222 and pixel_column < 416 and text_data = '1' else
		
		not text_data when (score0 = 53 and mode = "100") else -- Make background yellow so bird is invisible for lvl 3
		not text_data when (mode = "010") else -- Make background cyan when lvl 1

		
		text_data;
	blue <= --text_data when text_data = '1' and mode = "110" else -- Win screen
		text_data when text_data = '1' and mode = "111" else -- Game Over
		text_data when text_data = '1' and mode > 0 else -- GameMode
		not bird when bird = '1' and mode > 0 else 
		
		-- pink pipes for lvl 2 -----------------------------------------
		pipe_1 when pipe_1 = '1' and mode = "011" else -- Green for others
		pipe_2 when pipe_2 = '1' and mode = "011" else -- Green for others
		pipe_3 when pipe_3 = '1' and mode = "011" else -- Green for others
		------------------------------------------------------------------
		
		-- Red pipes for lvl 3 -----------------------------------------
		not pipe_1 when pipe_1 = '1' and mode = "100" else -- Green for others
		not pipe_2 when pipe_2 = '1' and mode = "100" else -- Green for others
		not pipe_3 when pipe_3 = '1' and mode = "100" else -- Green for others
		------------------------------------------------------------------
		
		-- Pipes for others -----------------------------------------------------------------------------------------------------------
		not pipe_1 when pipe_1 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		not pipe_2 when pipe_2 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		not pipe_3 when pipe_3 = '1' and mode > 0 and mode /= "011" and mode /= "100" else -- Green for others
		------------------------------------------------------------------------------------------------------------------------------
		
		text_data when mode = "000" and pixel_row > 30 and pixel_row < 48 else
		not text_data when mode = "000" and pixel_row > 62 and pixel_row < 80 else
		not text_data when mode = "000" and pixel_row > 222 and pixel_row < 256 and pixel_column > 222 and pixel_column < 416 and not text_data = '1' else		
		
		
		not text_data when (mode = "010") else -- Make background cyan when lvl 1
		not text_data when (mode = "011") else -- Make background Blue when lvl 2
		text_data;
		
		
		
end architecture behaviour;