library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keypad is
    Port ( 
			  clk: in  STD_LOGIC;
			  JA : inout  STD_LOGIC_VECTOR (7 downto 0);
			  Decoded : out STD_LOGIC_VECTOR(3 downto 0)
	      );
end keypad;

architecture arch_keypad of keypad is

component Decoder is
	Port (
			 clk : in  STD_LOGIC;
          Row : in  STD_LOGIC_VECTOR (3 downto 0);
			 Col : out  STD_LOGIC_VECTOR (3 downto 0);
          DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0)

          );
	end component;
	
component REG_4bits is
  Port ( 
    DATA : in STD_LOGIC_VECTOR(3 downto 0);
    RESET, LD, clk: in STD_LOGIC;
    O : out STD_LOGIC_VECTOR(3 downto 0)  
  );
end component;

begin
	C0: Decoder port map (clk=>clk, Row =>JA(7 downto 4), Col=>JA(3 downto 0), DecodeOut=> Decoded);
end arch_keypad;

