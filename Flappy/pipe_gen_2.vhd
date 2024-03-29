LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all;

entity pipe_gen_2 is
port(mode : in std_logic_vector(2 downto 0);
		pixel_row, pixel_column : in std_logic_vector(9 downto 0);
		rand_num : in std_logic_vector(3 downto 0);
		vert_sync : in std_logic;
		pipe_1_pos : in std_logic_vector(9 downto 0);
		pipe_on : out std_logic;
		rand_num_flag : out std_logic_vector(3 downto 0));
end entity pipe_gen_2;

architecture behaviour of pipe_gen_2 is
	signal pipe_width : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(24,10);
	signal pipe_x_pos : std_logic_vector(9 downto 0):= CONV_STD_LOGIC_VECTOR(670,10);
	signal pipe_display : std_logic;
begin
	pipe_on <= '1' when  ('0' & pipe_x_pos <= '0' & pixel_column + pipe_width) and ('0' & pixel_column <= '0' & pipe_x_pos + pipe_width) and pipe_display = '1'	-- x_pos - size <= pixel_column <= x_pos + size
					else '0';

	pipe_move : process(pixel_row, pixel_column, mode, vert_sync)
	begin
	-- Move pipe once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Compute next pipe X position
		if (pipe_1_pos < CONV_STD_LOGIC_VECTOR(220,10)) then -- if the first pipe is halfway across the screen
			pipe_x_pos <= pipe_x_pos - CONV_STD_LOGIC_VECTOR(5,10); -- start moving this pipe
		elsif (pipe_x_pos > CONV_STD_LOGIC_VECTOR(0,10) and pipe_x_pos < CONV_STD_LOGIC_VECTOR(670,10)) then -- if this pipe is already moving
			pipe_x_pos <= pipe_x_pos - CONV_STD_LOGIC_VECTOR(5,10);
		else
			pipe_x_pos <= CONV_STD_LOGIC_VECTOR(670,10);
		end if;
	end if;
	end process pipe_move;
	
	pipe_gap: process(pixel_row, pixel_column, rand_num)
	begin
		pipe_display <= '1';
		case rand_num is
			WHEN "0001" =>
				IF(pixel_row >= 150 AND pixel_row <= 220) THEN
					pipe_display <= '0';
				END IF;
			WHEN "0010" =>
				IF(pixel_row >= 220 AND pixel_row <= 290) THEN
					pipe_display <= '0';
				END IF;
			WHEN "0011" =>
				IF(pixel_row >= 290 AND pixel_row <= 360) THEN
					pipe_display <= '0';
				END IF;
			WHEN "0100" =>
				IF(pixel_row >= 360 AND pixel_row <= 430) THEN
					pipe_display <= '0';
				END IF;
			WHEN "0101" =>
				IF(pixel_row >= 165 AND pixel_row <= 235) THEN
					pipe_display <= '0';
				END IF;
			WHEN "0110" =>
				IF(pixel_row >= 235 AND pixel_row <= 305) THEN
					pipe_display <= '0';
				END IF;
			WHEN "0111" =>
				IF(pixel_row >= 305 AND pixel_row <= 375) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1000" =>
				IF(pixel_row >= 180 AND pixel_row <= 250) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1001" =>
				IF(pixel_row >= 250 AND pixel_row <= 320) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1010" =>
				IF(pixel_row >= 320 AND pixel_row <= 390) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1011" =>
				IF(pixel_row >= 200 AND pixel_row <= 270) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1100" =>
				IF(pixel_row >= 270 AND pixel_row <= 340) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1101" =>
				IF(pixel_row >= 340 AND pixel_row <= 410) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1110" =>
				IF(pixel_row >= 190 AND pixel_row <= 260) THEN
					pipe_display <= '0';
				END IF;
			WHEN "1111" =>
				IF(pixel_row >= 220 AND pixel_row <= 290) THEN
					pipe_display <= '0';
				END IF;
			WHEN others =>
					pipe_display <= '1';
		END CASE;
	end process pipe_gap;
	
	lsfr_gen : process(pixel_column, pipe_x_pos)
	begin
		if (pipe_x_pos >= CONV_STD_LOGIC_VECTOR(660,10) and pipe_x_pos <= CONV_STD_LOGIC_VECTOR(670,10))  then
			rand_num_flag <= rand_num;
		end if;
	end process lsfr_gen;
end architecture behaviour;