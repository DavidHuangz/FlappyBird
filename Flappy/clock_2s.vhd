library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity clock_2s is
  port(Clock : in std_logic;
       clock_out : out std_logic);
end entity clock_2s;

architecture behaviour of clock_2s is
  signal clock_2s_count : integer range 0 to 50000000 := 0;
  signal clock_2s_temp : std_logic := '0';
begin
  process(clock)
    begin
    if rising_edge(Clock) then
      if (clock_2s_count>49999999) then
        clock_2s_count <= 0;
        clock_2s_temp <= NOT clock_2s_temp;
      else
        clock_2s_count <= clock_2s_count + 1;
      end if;
    end if;
  end process;
  clock_out <= clock_2s_temp;
end behaviour;