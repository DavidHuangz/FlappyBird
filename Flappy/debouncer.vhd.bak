library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
port
(
	clk : in std_logic;
	input : in std_logic;
	output : out std_logic
);
end entity;

architecture behaviour1 of debouncer is
	begin
		process(clk)
		variable cnt : unsigned(7 downto 0) := "00000000";
		variable seconds: unsigned(17 downto 0) := (others => '0');
		--the number of clock cycles per increment is 250000 for a time value of 5ms = 0b111101000010010000 per increment
		--counting 20 of these increments should get us 100ms, enough to decide if a signal has been stable long enough
		begin
			if (rising_edge(clk)) then
				if input = '1' then
						if seconds = "111101000010010000" then
							seconds := (others => '0'); --reset seconds
							if cnt = "00010100" then --count up to 0x14 (0d20)
								output <= '1';
								cnt := "00000000";
							else
								cnt := cnt + 1;
							end if;
						else
							seconds := seconds + 1;
						end if;
				else --reset counters
					seconds := (others => '0');
					cnt := (others => '0');
					output <= '0';
				end if;
			end if;
		end process;
end behaviour1;