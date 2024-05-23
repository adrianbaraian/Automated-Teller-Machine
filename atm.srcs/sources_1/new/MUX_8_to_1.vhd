LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY MUX_8_to_1 IS
  PORT (
  	INPUT0, INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7 : in STD_LOGIC_VECTOR(31 downto 0);
  	SEL : in STD_LOGIC_VECTOR(2 downto 0);
  	OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
  );
END MUX_8_to_1;

ARCHITECTURE ARH_MUX_8_to_1 OF MUX_8_to_1 IS

BEGIN

	with SEL select OUTPUT <=
		INPUT0 when "000",
		INPUT1 when "001",
		INPUT2 when "010",
		INPUT3 when "011",
		INPUT4 when "100",
		INPUT5 when "101",
		INPUT6 when "110",
		INPUT7 when others;
		
END ARH_MUX_8_to_1;
