library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
port(clk : in std_logic;
	  input : in std_logic;
	  output : out std_logic);
end entity;
-- Clock cycles per increment is 250000 for a time value of 0.01s per increment
--	Count value of 5 gives 0.05s which should be enough time 
--	for a single signal to be acted upon for a single opening or closing of a contact 
architecture behaviour1 of debouncer is
signal counter : unsigned(7 downto 0) := (others => '0');
signal time_val: unsigned(17 downto 0) := (others => '0');
	begin
		process(clk)
		begin
			if (rising_edge(clk)) then
				if input = '1' then
						if time_val = 250000 then
							time_val <= (others => '0'); 
							if counter = 5 then 
								output <= '1';
								counter <= "00000000";
							else
								counter <= counter + 1;
							end if;
						else
							time_val <= time_val + 1;
						end if;
				else 
					time_val <= (others => '0');
					counter <= (others => '0');
					output <= '0';
				end if;
			end if;
		end process;
end behaviour1;