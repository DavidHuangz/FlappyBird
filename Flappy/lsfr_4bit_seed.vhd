library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lsfr_4bit_seed is
	port(mode : in std_logic_vector(2 downto 0);
		lsfr_seed_1, lsfr_seed_2, lsfr_seed_3 : out std_logic_vector(3 downto 0));
end entity lsfr_4bit_seed;

architecture behaviour of lsfr_4bit_seed is
begin
	lsfr_seed_1 <= "0000" when mode = "000" or mode = "111" or mode = "110" else "0101";
	lsfr_seed_2 <= "0000" when mode = "000" or mode = "111" or mode = "110" else "0001";
	lsfr_seed_3 <= "0000" when mode = "000" or mode = "111" or mode = "110" else "1001";
end architecture behaviour;