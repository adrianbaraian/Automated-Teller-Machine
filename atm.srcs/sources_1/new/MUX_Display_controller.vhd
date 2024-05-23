library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity MUX_Display_controller is
  Port (
    INPUT0, INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7, INPUT8, INPUT9, INPUT10, INPUT11, INPUT12, INPUT13, INPUT14, INPUT15 : in STD_LOGIC_VECTOR(15 downto 0);
    SEL : in STD_LOGIC_VECTOR(3 downto 0);
    OUTPUT : out STD_LOGIC_VECTOR(15 downto 0)  
  );
end MUX_Display_controller;

architecture arch_MUX_Display_controller of MUX_Display_controller is
begin
    with SEL select OUTPUT <=
		INPUT0 when "0000",
		INPUT1 when "0001",
		INPUT2 when "0010",
		INPUT3 when "0011",
		INPUT4 when "0100",
		INPUT5 when "0101",
		INPUT6 when "0110",
		INPUT7 when "0111",
		INPUT8 when "1000",
		INPUT9 when "1001",
		INPUT10 when "1010",
		INPUT11 when "1011",
		INPUT12 when "1100",
		INPUT13 when "1101",
		INPUT14 when "1110",
		INPUT15 when others;
end arch_MUX_Display_controller;
