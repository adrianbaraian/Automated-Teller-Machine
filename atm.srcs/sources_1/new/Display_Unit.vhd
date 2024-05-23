library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Display_Unit is
  Port (
    INPUT0, INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7, INPUT8, INPUT9, INPUT10, INPUT11, INPUT12, INPUT13, INPUT14, INPUT15 : in STD_LOGIC_VECTOR(15 downto 0);
    an : out STD_LOGIC_VECTOR(3 downto 0);
    seg : out STD_LOGIC_VECTOR(6 downto 0);
    SEL : in STD_LOGIC_VECTOR(3 downto 0);
    clk : in STD_LOGIC
   );
end Display_Unit;

architecture Behavioral of Display_Unit is
component MUX_Display_controller is
    Port (
    INPUT0, INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7, INPUT8, INPUT9, INPUT10, INPUT11, INPUT12, INPUT13, INPUT14, INPUT15 : in STD_LOGIC_VECTOR(15 downto 0);
    SEL : in STD_LOGIC_VECTOR(3 downto 0);
    OUTPUT : out STD_LOGIC_VECTOR(15 downto 0)  
  );
end component;

component Display_controller is
    PORT (    
    BCD_IN : in STD_LOGIC_VECTOR(15 downto 0);
  	an : out STD_LOGIC_VECTOR (3 DOWNTO 0);
  	clk : in STD_LOGIC;
  	seg : out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

signal O_MUX : STD_LOGIC_VECTOR(15 downto 0);

begin
    C0 : MUX_Display_controller port map (INPUT0 => INPUT0, INPUT1 => INPUT1, INPUT2 => INPUT2, INPUT3 => INPUT3, INPUT4 => INPUT4, INPUT5 => INPUT5, INPUT6 => INPUT6, INPUT7 => INPUT7, INPUT8 => INPUT8, INPUT9 => INPUT9, INPUT10 => INPUT10, INPUT11=> INPUT11, INPUT12 => INPUT12, INPUT13 => INPUT13, INPUT14 => INPUT14, INPUT15 => INPUT15, SEL => SEL, OUTPUT => O_MUX);
    C1 : Display_controller port map (BCD_IN => O_MUX, an => an, seg => seg, clk => clk );
end Behavioral;
