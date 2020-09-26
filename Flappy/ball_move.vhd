LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY ball_move IS
	PORT
		(SIGNAL clk, vert_sync, left_button	: IN std_logic;
        SIGNAL pixel_row, pixel_column		: IN std_logic_vector(9 DOWNTO 0);
		SIGNAL red, green, blue 			: OUT std_logic);		
END ball_move;

architecture behavior of ball_move is

SIGNAL ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);
SIGNAL direction 				: std_logic := '0';

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_x_pos <= CONV_STD_LOGIC_VECTOR(300,11);

ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Ball is yellow
Red <= '1' when ball_on = '1' else '0';
Green <= '1' when ball_on = '1' else '0';
Blue <=  '0';

Ball_Direction: process(left_button)
begin
	if falling_edge(left_button) then
		direction <= not direction; -- 0 is going down, 1 is going up
	end if;
end process Ball_Direction;

Move_Ball: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Bounce off top or bottom of the screen
		if (direction = '1' and ball_y_pos > size) then
			ball_y_motion <= - CONV_STD_LOGIC_VECTOR(2,10);
		elsif (direction = '0' and '0' & ball_y_pos < CONV_STD_LOGIC_VECTOR(479,10) - size) then 
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		else
			ball_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
		end if;
		-- Compute next ball Y position
		ball_y_pos <= ball_y_pos + ball_y_motion;
	end if;
end process Move_Ball;

END behavior;

