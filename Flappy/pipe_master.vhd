LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all;

entity pipe_master is
port(mode : in std_logic_vector(2 downto 0);
		pixel_row, pixel_column : in std_logic_vector(9 downto 0);
		vert_sync : in std_logic;
		pipe_pos_1 : in std_logic_vector(9 downto 0);
		pipe_pos_2 : in std_logic_vector(9 downto 0);
		pipe_pos_3 : in std_logic_vector(9 downto 0);
		enable_1 : out std_logic;
		enable_2 : out std_logic;
		enable_3 : out std_logic;
		reset_1 : out std_logic;
		reset_2 : out std_logic;
		reset_3 : out std_logic);
end entity pipe_master;

architecture behaviour of pipe_master is

	signal pipe_width : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(16,10);
	
begin
	pipe_controller : process(vert_sync, mode, pipe_pos_1, pipe_pos_2, pipe_pos_3)
		variable enable_1_save, enable_2_save, enable_3_save : std_logic := '0';
	begin
		if mode = 0 then
			enable_1 <= '0';
			enable_2 <= '0';
			enable_3 <= '0';
			reset_1 <= '1';
			reset_2 <= '1';
			reset_3 <= '1';
	elsif (mode = "001" or mode = "010" or mode = "011" or mode = "100") then
			if rising_edge(vert_sync) then 
				if (pipe_pos_1 <= 660) then
					reset_1 <= '0';
					enable_1_save := '1';
				elsif (pipe_pos_1 <= pipe_width) then
					reset_1 <= '1';
					enable_1_save := '0';
				end if;
				-- 2nd pipe begins after 1st pipe goes past 1/3 of the screen
				if (pipe_pos_1 > 440 and pipe_pos_2 >= 440) then
					reset_2 <= '1';
					enable_2_save := '0';
				elsif (pipe_pos_1 <= 440) then
					reset_2 <= '0';
					enable_2_save := '1';
				elsif (pipe_pos_2 <= pipe_width) then
					reset_2 <= '1';
					enable_2_save := '0';
				end if;
				--3rd pipe begins after 1st pipe goes past 2/3 of the screen
				if (pipe_pos_1 > 220 and pipe_pos_3 >= 440) then
					reset_3 <= '1';
					enable_3_save := '0';
				elsif (pipe_pos_1 <= 220) then

					reset_3 <= '0';
					enable_3_save := '1';
				elsif (pipe_pos_3 <= pipe_width) then
					reset_3 <= '1';
					enable_3_save := '0';
				end if;
			enable_1 <= enable_1_save;
			enable_2 <= enable_2_save;
			enable_3 <= enable_3_save;
--			enable_1_save := enable_1_save;
--			enable_2_save := enable_2_save;
--			enable_3_save := enable_3_save;
			end if;
		end if;
	end process pipe_controller;
	
end architecture behaviour;