LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all;

entity mode is
	port(clk, left_button, right_button, pause_switch, menu_button, gameover : in std_logic;
		Health_Bar 	: in std_logic_vector(3 downto 0);	
		level : in std_logic_vector(2 downto 0);
		mode_output : out std_logic_vector(2 downto 0);
		led_output : out std_logic_vector(9 downto 0));
end entity;

architecture behaviour of mode is
	signal mode : std_logic_vector(2 downto 0) := "000";
	signal next_mode : std_logic_vector(2 downto 0) := "000";
	signal prev_mode : std_logic_vector(2 downto 0) := "000";
begin

	mode_output <= mode;
	led_output <= "1111111111" when mode = "000" else -- menu
					"1111100000" when mode = "001" else -- training
					"0000011111" when mode = "010" else -- level 1
					"0001111111" when mode = "011" else -- level 2
					"0111111111" when mode = "100" else -- level 3
					"1010101010" when mode = "110" else -- win
					"0110110110" when mode = "101" else -- pause
					"0101010101" when mode = "111" else -- game over
					"0000000000";
	mode_out: process(clk, next_mode) --synchronously move to next state
	begin
		if rising_edge(clk) then
			mode <= next_mode;
		end if;
	end process;
	
	next_state: process(mode, left_button, right_button, pause_switch, menu_button, level, GameOver, Health_Bar, prev_mode) 
	begin
		case mode is
		
		
			-- When Main Menu
			when "000" =>
				if (left_button = '1') then
					-- Training
					prev_mode <= "001";
					next_mode <= "001";
				elsif (right_button = '1') then
					-- GameMode
					prev_mode <= "010";
					next_mode <= "010";
				else
					prev_mode <= "000";
					next_mode <= "000";
				end if;
				
				
			-- When training mode 
			when "001" =>
				if (pause_switch = '1') then
					-- Pause switch
					next_mode <= "101";
				elsif (menu_button = '0') then
					-- Main button
					next_mode <= "000";
				else
					prev_mode <= "001";
					next_mode <= "001";
				end if;
				
				
			-- When game mode: level 1
			when "010" => 
				if (pause_switch = '1') then
					-- Pause switch
					next_mode <= "101";
				elsif (menu_button = '0') then
					-- Main button
					next_mode <= "000"; 
				elsif (GameOver = '1' or Health_Bar = "0000") then
					next_mode <= "111";
				-- level change to level 2
				elsif not (level = mode) then
					next_mode <= level;
				else
					prev_mode <= "010";
					next_mode <= "010";
				end if;

				
			-- When game mode: level 2	
			when "011" => 
				if (pause_switch = '1') then
					-- Pause switch
					next_mode <= "101";
				elsif (menu_button = '0') then
					-- Main button
					next_mode <= "000"; 
				elsif (GameOver = '1' or Health_Bar = "0000") then
					next_mode <= "111";
				-- level change to level 3
				elsif not (level = mode) then
					next_mode <= level;
				else			
					prev_mode <= "011";
					next_mode <= "011";
				end if;
				
				
			-- When game mode: level 3				
			when "100" => 
				if (pause_switch = '1') then
					-- Pause switch
					next_mode <= "101";
				elsif (menu_button = '0') then
					-- Main button
					next_mode <= "000"; 
				elsif (GameOver = '1'or Health_Bar = "0000") then
					next_mode <= "111";
				-- level change to win screen
				elsif not (level = mode) then
					next_mode <= level;
				else
					prev_mode <= "100";
					next_mode <= "100";
				end if;
				
				
			-- When pause screen
			when "101" =>
				if (pause_switch = '0') then
					-- Resume 
					next_mode <= prev_mode;
				elsif (menu_button = '0') then
					-- Main button
					next_mode <= "000";
				else
					-- Remain pause
					next_mode <= "101";	
				end if;
				
				
			-- When winning screen
			when "110" =>
				-- Menu_button to menu and right_button to restart
				if (menu_button = '0' or right_button = '1') then
					-- Main button
					next_mode <= "000"; 
				else
					next_mode <= "110";
				end if;
			
			
			-- When GameOver screen
			when "111" =>
				-- Menu_button to menu and right_button to restart
				if (menu_button = '0' or right_button = '1') then
					next_mode <= "000";	
				else
					next_mode <= "111";
				end if;	

			when others =>
				next_mode <= "000";
				prev_mode <= "000";
				
		end case;
	end process;
	
end architecture behaviour;