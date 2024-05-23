library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity REG_Block is
  Port (
        DATA_in : in STD_LOGIC_VECTOR(31 downto 0);
        SEL : in STD_LOGIC_VECTOR(2 downto 0);
        RESET, clk : in STD_LOGIC;
        LD_REG_block : in STD_LOGIC;
        DATA_out : out STD_LOGIC_VECTOR(31 downto 0) 
  );
end REG_Block;

architecture Behavioral of REG_Block is
component REG_pin_money is
    Port (
    DATA : in STD_LOGIC_VECTOR(31 downto 0);
    RESET, LD, clk: in STD_LOGIC;
    O : out STD_LOGIC_VECTOR(31 downto 0)
       );
end component;
component MUX_8_to_1 IS
  PORT (
  	INPUT0, INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7 : in STD_LOGIC_VECTOR(31 downto 0);
  	SEL : in STD_LOGIC_VECTOR(2 downto 0);
  	OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
   );
end component;
component DMUX_1_to_8 IS
  PORT (
  	INPUT : in STD_LOGIC_VECTOR(31 downto 0);
  	SEL : in STD_LOGIC_VECTOR(2 downto 0);
  	OUTPUT0, OUTPUT1 ,OUTPUT2, OUTPUT3, OUTPUT4, OUTPUT5 ,OUTPUT6, OUTPUT7 : out STD_LOGIC_VECTOR(31 downto 0)
   );
end component;
signal i00, i01, i02, i03, i04, i05, i06, i07 : STD_LOGIC_VECTOR(31 downto 0);
signal i10, i11, i12, i13, i14, i15, i16, i17 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal LD0, LD1, LD2, LD3 : STD_LOGIC;
begin
    process(SEL, LD_REG_block)
    begin
    LD0 <= '0'; LD1 <= '0'; LD2 <= '0'; LD3 <= '0';
        case SEL is
            when "000" =>
                LD0 <= LD_REG_block;
            when "001" =>
                LD1 <= LD_REG_block;
            when "010" => 
                LD2 <= LD_REG_block;
            when "011" => 
                LD3 <= LD_REG_block;
            when others => null;
        end case;
    end process;

    C0 : DMUX_1_to_8 port map (INPUT => DATA_in, SEL => SEL, OUTPUT0 => i00, OUTPUT1 => i01, OUTPUT2 => i02, OUTPUT3 => i03, OUTPUT4 => i14, OUTPUT5 => i15, OUTPUT6 => i16, OUTPUT7 => i17);
    
    C1 : REG_pin_money port map(DATA => i00, RESET => RESET, LD => LD0, clk =>clk, O => i10);
    C2 : REG_pin_money port map(DATA => i01, RESET => RESET, LD => LD1, clk =>clk, O => i11);
    C3 : REG_pin_money port map(DATA => i02, RESET => RESET, LD => LD2, clk =>clk, O => i12);
    C4 : REG_pin_money port map(DATA => i03, RESET => RESET, LD => LD3, clk =>clk, O => i13);
    
    C5 : MUX_8_to_1 port map(INPUT0 => i10, INPUT1 => i11, INPUT2 => i12, INPUT3 => i13, INPUT4 => i14, INPUT5 => i15, INPUT6 => i16, INPUT7 => i17, SEL => SEL, OUTPUT => DATA_out);
end Behavioral;
