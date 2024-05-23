library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Read_module is
  Port (
    clk_dec, clk_reg : in STD_LOGIC;
    JA : inout STD_LOGIC_VECTOR(7 downto 0);
    RESET_REG : in STD_LOGIC;
    LD, LD_UC : in STD_LOGIC;
    OUTPUT : inout STD_LOGIC_VECTOR(15 downto 0) := x"FFFF";
    SEL : out STD_LOGIC_VECTOR(3 downto 0);
    O_citit : inout STD_LOGIC_VECTOR(3 downto 0)
   );
end Read_module;

architecture arch_Read_module of Read_module is
component keypad is
     Port ( 
			  clk: in  STD_LOGIC;
			  JA : inout  STD_LOGIC_VECTOR (7 downto 0);
			  Decoded : out STD_LOGIC_VECTOR(3 downto 0)

	      );
end component;
component REG_4bits is
  Port ( 
    DATA : in STD_LOGIC_VECTOR(3 downto 0);
    RESET, LD, clk: in STD_LOGIC;
    O : out STD_LOGIC_VECTOR(3 downto 0)  
  );
end component;
component Shifting_REG is
  Port ( 
    DATA_in : in STD_LOGIC_VECTOR(3 downto 0);
    DATA_out : inout STD_LOGIC_VECTOR(11 downto 0);
    SHIFT, RESET, clk : in STD_LOGIC
  );
end component;
--signal in_reg : STD_LOGIC_VECTOR(3 downto 0);
signal O0 : STD_LOGIC_VECTOR(3 downto 0);
signal O1 : STD_LOGIC_VECTOR(11 downto 0);
begin
    C0 : keypad port map (clk => clk_dec, JA => JA, Decoded => O_citit);
    --card REG
    CARD : REG_4bits port map(DATA => O_citit, RESET => RESET_REG, LD => LD_UC, clk => clk_reg, O => SEL);
    --pin
    PIN1 : REG_4bits port map(DATA => O_citit, RESET => RESET_REG, LD => LD, clk => clk_reg, O => O0);
    PIN2 : Shifting_REG port map(DATA_in => O0, RESET => RESET_REG, SHIFT => LD, clk => clk_reg, DATA_out => O1);
    OUTPUT <= O1 & O0;
    --PIN_TH : REG_4bits port map(DATA => O_citit, RESET => RESET_REG, LD => LD, clk => clk, O => OUTPUT(15 downto 12));
    --PIN_H : REG_4bits port map(DATA => OUTPUT(15 downto 12), RESET => RESET_REG, LD => LD, clk => clk, O => OUTPUT(11 downto 8));
    --PIN_T : REG_4bits port map(DATA => OUTPUT(11 downto 8), RESET => RESET_REG, LD => LD, clk => clk, O => OUTPUT(7 downto 4));
    --PIN_U : REG_4bits port map(DATA => OUTPUT(7 downto 4), RESET => RESET_REG, LD => LD, clk => clk, O => OUTPUT(3 downto 0));
    --C4 : REG_4bits port map(DATA => in_reg, RESET => RESET_REG, LD => LD_UP, clk => clk, O => OUTPUT(3 downto 0));
    --card REG
    --C5 : REG_4bits port map(DATA => in_reg, RESET => RESET_REG, LD => LD_UC, clk => clk, O => SEL);
    
    
end arch_Read_module;
