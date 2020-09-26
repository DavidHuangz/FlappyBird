library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lsfr_4bit is
	port(clk : in std_logic;
		lsfr_seed : in std_logic_vector(3 downto 0);
		lsfr_num : out std_logic_vector(3 downto 0));
end entity;

architecture behaviour of lsfr_4bit is
	signal number : std_logic_vector(3 downto 0) := "0000";
begin
	
	process(clk, lsfr_seed)
		variable number_temp : std_logic_vector(3 downto 0) := "0000";
	begin
	
		if (lsfr_seed = "0000") then -- pattern resets every time game restarts
			number_temp := lsfr_seed;
		elsif rising_edge(clk) then
			number_temp(1) := number(0) XOR number(3);
			number_temp(2) := number(1);
			number_temp(3) := number(2);
			number_temp(0) := number(3);
			if number_temp = "0000" then
				number_temp := lsfr_seed;
			end if;
		end if;
		lsfr_num <= number_temp;
		number <= number_temp;
	end process;
end architecture behaviour;