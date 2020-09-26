library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity seven_segment is 
port (digit1: in std_logic_vector(3 downto 0);
      out0 : out std_logic;
		out1 : out std_logic;
		out2 : out std_logic;
		out3 : out std_logic;
		out4 : out std_logic;
		out5 : out std_logic;
		out6 : out std_logic);
end entity seven_segment;

architecture arc1 of seven_segment is
  signal temp1: std_logic_vector(6 downto 0) := (others => '0');
begin 
------------------------------- Seven Segment decoder -----------------------------------------------------
-- Seven segment decoder1
	temp1 <= "1111001" when digit1 = "0001" else --1
	"0100100" when digit1 = "0010" else -- 2
	"0110000" when digit1 = "0011" else -- 3
	"0011001" when digit1 = "0100" else -- 4
	"0010010" when digit1 = "0101" else -- 5
	"0000010" when digit1 = "0110" else -- 6
	"1111000" when digit1 = "0111" else -- 7
	"0000000" when digit1 = "1000" else -- 8
	"0011000" when digit1 = "1001" else -- 9
	"0001000" when digit1 = "1010" else -- A
	"0000011" when digit1 = "1011" else -- b
	"1000110" when digit1 = "1100" else -- C
	"0100001" when digit1 = "1101" else -- d
	"0000110" when digit1 = "1110" else -- E
	"0001110" when digit1 = "1111" else -- F
	"1000000";

  process(temp1)
  begin	
	 out0 <= temp1(0);
	 out1 <= temp1(1);
	 out2 <= temp1(2);
	 out3 <= temp1(3);
	 out4 <= temp1(4);
	 out5 <= temp1(5);
	 out6 <= temp1(6);
	end process;
------------------------------- Seven Segment decoder -----------------------------------------------------
end architecture arc1;