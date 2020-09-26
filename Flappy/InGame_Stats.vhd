LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;



ENTITY InGame_stats IS
	PORT
	  (mode 										: IN std_logic_vector(2 downto 0);
		vert_sync								: IN std_logic;
		pixel_row, pixel_column				: IN std_logic_vector(9 DOWNTO 0);
		ball_posx, ball_posy					: IN std_logic_vector(9 DOWNTO 0);
		pipe_pos_1, pipe_pos_2, pipe_pos_3 	: IN std_logic_vector(9 downto 0);
		pipe_gap_1, pipe_gap_2, pipe_gap_3 	: IN std_logic_vector(9 downto 0);		
		GameOver									: IN std_logic;
		score0 									: OUT std_logic_vector(5 downto 0);	
		score1 									: OUT std_logic_vector(5 downto 0);
		level 									: OUT std_logic_vector(2 downto 0);
		Health_Bar 								: OUT std_logic_vector(3 downto 0));	
END InGame_stats;

architecture behavior of InGame_stats is

	signal s0 : std_logic_vector(3 downto 0) := "0000";	
	signal s1 : std_logic_vector(3 downto 0) := "0000";	
	signal ball_size : std_logic_vector(9 DOWNTO 0);
	signal pipe_width : std_logic_vector(9 DOWNTO 0);
	signal pipe_gap_height : std_logic_vector(9 DOWNTO 0);
	signal collision, health_up : std_logic := '0';
	signal Health1 :  std_logic_vector(3 downto 0) := "0000";
	signal Health2 :  std_logic_vector(3 downto 0) := "0111";
	
BEGIN
	score0 <= "11" & s0;
	score1 <= "11" & s1;
	Health_Bar <= Health2 - Health1;
	ball_size <= CONV_STD_LOGIC_VECTOR(8,10);
	pipe_width <= CONV_STD_LOGIC_VECTOR(16,10);
	pipe_gap_height <= CONV_STD_LOGIC_VECTOR(70,10);
	
	collision_detect : process(vert_sync)
		variable collision_pipe : std_logic_vector(2 downto 0) := "000";
	begin
		if rising_edge(vert_sync) then
			if (pipe_pos_1 - pipe_width <= ball_posx + ball_size and ball_posx - ball_size <= pipe_pos_1 + pipe_width 
					and (ball_posy - ball_size < pipe_gap_1 or ball_posy + ball_size > pipe_gap_1 + pipe_gap_height)) then
				collision_pipe := "001";
			elsif (pipe_pos_2 - pipe_width <= ball_posx + ball_size and ball_posx - ball_size <= pipe_pos_2 + pipe_width 
					and (ball_posy - ball_size < pipe_gap_2 or ball_posy + ball_size > pipe_gap_2 + pipe_gap_height)) then
				collision_pipe := "010";
			elsif (pipe_pos_3 - pipe_width <= ball_posx + ball_size and ball_posx - ball_size <= pipe_pos_3 + pipe_width 
					and (ball_posy - ball_size < pipe_gap_3 or ball_posy + ball_size > pipe_gap_3 + pipe_gap_height)) then
				collision_pipe := "011";
			end if;
			
			case collision_pipe is
			when "001" =>
				if (ball_posx - pipe_width > pipe_pos_1 + pipe_width) then
					collision <= '0';
					collision_pipe := "000";
				else
					collision <= '1';
				end if;
			when "010" =>
				if (ball_posx - pipe_width > pipe_pos_2 + pipe_width) then
					collision <= '0';
					collision_pipe := "000";
				else
					collision <= '1';
				end if;
			when "011" =>
				if (ball_posx - pipe_width > pipe_pos_3 + pipe_width) then
					collision <= '0';
					collision_pipe := "000";
				else
					collision <= '1';
				end if;
			when others =>
				collision <= '0';
			end case;
		end if;
	end process collision_detect;
	
	Score_Pipe : process(vert_sync, pipe_pos_1, pipe_pos_2, pipe_pos_3, ball_posx, mode)
	begin
		if (rising_edge(vert_sync)) then	
				-- When restart button pressed
			if (mode = "000") then	
				s0 <= "0000"; 
				s1 <= "0000";
				-- If paused or GameOver, when ball = pipe, then it does not increment infinitely
			elsif (mode = "101" or mode = "111") then
				s0 <= s0; 
				s1 <= s1;
			elsif ( (ball_posx - ball_size = pipe_pos_1 + pipe_width and ball_posy - ball_size > pipe_gap_1 and ball_posy + ball_size < pipe_gap_1 + pipe_gap_height) or
				(ball_posx - ball_size = pipe_pos_2 + pipe_width and ball_posy - ball_size > pipe_gap_2 and ball_posy + ball_size < pipe_gap_2 + pipe_gap_height) or
				(ball_posx - ball_size = pipe_pos_3 + pipe_width and ball_posy - ball_size > pipe_gap_3 and ball_posy + ball_size < pipe_gap_3 + pipe_gap_height) ) then
				if (collision = '0') then
					if (s0 = "0100" or s0 = "1001") then -- gain health every 5 score
						health_up <= '1';
					else
						health_up <= '0';
					end if;
					s0 <= s0 + '1';
					if s0 = 9 then
						s0 <= "0000";
						s1 <= s1 + '1';
					end if;
				end if;
			end if;
		end if;
		
	-- Makes sure score is reseted after restarting
	if (mode = "000") then	
		s0 <= "0000"; 
		s1 <= "0000";
	end if;
	
	end process Score_Pipe;
	
	level_change : process(vert_sync, s0, s1)
		variable level_save : std_logic_vector(2 downto 0) := "010";
	begin
		if rising_edge(vert_sync) then
			case mode is
			when "010" => -- level 1, cleared 15 pipes
				if (s1 >= 1 and s0 >= 5 ) then
					level_save := "011"; -- to level 2
				end if;
			when "011" => -- level 2, cleared 35 pipes
				if (s1 >= 3 and s0 >= 5 ) then
					level_save := "100"; -- to level 3
				end if;
			when "100" => -- level 3, cleared 55 pipes
				if (s1 >= 5 and s0 >= 5 ) then
					level_save := "110"; -- to win screen
				end if;
			-- Resets level back to menu
			when "000" =>
				level_save := "010";
			when "110" =>
				level_save := "010";
			when "111" =>
				level_save := "010";
			when others =>
				level_save := level_save;
			end case;
			level <= level_save;
		end if;
	end process level_change;
	
	
health_decrease : process (collision, mode)
	begin
		if rising_edge(collision) then
			if (Health2 - Health1 > 0) then
				Health1 <= Health1 + '1'; -- decrease health
			else
				Health1 <= Health1;
			end if;
		end if;
	
		if (mode = "000") then
			Health1 <= "0000";
		end if;
	end process health_decrease;
	
health_increase : process (health_up, mode) -- increase health
	begin
		if rising_edge(health_up) then
			if (Health2 - Health1 < 5) then -- maximum health is 6
				Health2 <= Health2 + 1;
			else
				Health2 <= Health2;
			end if;
		end if;
		if (mode = "000") then
			Health2 <= "0111";
		end if;
end process health_increase;

	
END behavior;
