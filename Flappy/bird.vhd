LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bird_move IS
	PORT
	  (mode : in std_logic_vector(2 downto 0);
		SIGNAL clk, vert_sync, left_button	: IN std_logic;
      SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL ball_posx, ball_posy			: OUT std_logic_vector(9 DOWNTO 0);
		SIGNAL bird_on 			: OUT std_logic;
		GameOver         : OUT std_logic := '0');
END bird_move;

architecture behavior of bird_move is

SIGNAL size 					: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(8,10);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(240,10);
SIGNAL ball_x_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);
SIGNAL direction 				: std_logic := '0';
SIGNAL starting_point		: std_logic := '0';	
BEGIN           

-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(300,10);
ball_posx <= ball_x_pos;
ball_posy <= ball_y_pos;

bird_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
-- lvl 2 increase bird size
size <= CONV_STD_LOGIC_VECTOR(12,10) when mode = "011" else 
        CONV_STD_LOGIC_VECTOR(8,10);
			

Move_Bird: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then		
		
		-- Bird movement
		-- Bird go up
		if (left_button = '1' and ball_y_pos > size) then
			ball_y_motion <= - CONV_STD_LOGIC_VECTOR(3,10);
		-- Bird go down
		elsif (left_button = '0' and '0' & ball_y_pos < CONV_STD_LOGIC_VECTOR(479,10) - size) then 
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(3,10);
			
		-- Stop bird from going out of map in Training mode
		elsif (mode = "001") then
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
		else
			-- GameOver when bird touches anything in GameMode
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
			GameOver <= '1';
		end if;
		
		-- Modes
		-- Menu to reset bird position in the center 	
		if (mode = "000" ) then
			ball_y_pos <= CONV_STD_LOGIC_VECTOR(240,10);
			GameOver <= '0';
		-- Pause	bird is static
		elsif (mode = "101") then	
			ball_y_pos <=  ball_y_pos;
		else
			-- Calculate next pos from bird movement
			ball_y_pos <= ball_y_pos + ball_y_motion;
		end if;
		
	end if;
end process Move_Bird;

END behavior;

