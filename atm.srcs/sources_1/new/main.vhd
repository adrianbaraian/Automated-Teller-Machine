library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity main is
  Port (
    clk : in STD_LOGIC;
    SEL_OP : in STD_LOGIC_VECTOR(1 downto 0);
    JA : inout STD_LOGIC_VECTOR(7 downto 0);
    an : out STD_LOGIC_VECTOR(3 downto 0);
    seg : out STD_LOGIC_VECTOR(6 downto 0);
    aici, idle_led : out STD_LOGIC;
    new_clock_out, interog : out STD_LOGIC;
   -- card, pin : out STD_LOGIC;
    START_BUT, OK_BUT, RESET_BUT : in STD_LOGIC
   );
end main;

architecture Behavioral of main is
signal LD_UC, LD, LD_mem_pin, LD_REG_sum, LD_ThN, LD_HN, LD_TN, LD_UN, CORRECT_PIN : STD_LOGIC;
signal Display_controller_sel : STD_LOGIC_VECTOR(3 downto 0);
component CU is
  Port (
      START : in STD_LOGIC;
      OK : in STD_LOGIC;
      clk : in STD_LOGIC;
      RESET : in STD_LOGIC;
      LD_UC, LD, LD_mem_pin, LD_REG_sum, LD_ThN, LD_HN, LD_TN, LD_UN, LD_REG_block: out STD_LOGIC;
     -- CARD, PIN : out STD_LOGIC := '1';
      SEL_OP : in STD_LOGIC_VECTOR(1 downto 0);
      Display_controller_sel : out STD_LOGIC_VECTOR(3 downto 0);
      CORRECT_PIN : in STD_LOGIC;
      aici, idle_led : out STD_LOGIC 
   );
end component; 

component comparatorBCD is
      Port (
       N1, N2 : in STD_LOGIC_VECTOR(15 downto 0);
       EQ, L : out STD_LOGIC    
       );
end component;

component REG_Block is
         Port (
        DATA_in : in STD_LOGIC_VECTOR(31 downto 0);
        SEL : in STD_LOGIC_VECTOR(2 downto 0);
        RESET, clk : in STD_LOGIC;
        LD_REG_block : in STD_LOGIC;
        DATA_out : out STD_LOGIC_VECTOR(31 downto 0) 
  );
end component;

component Read_module is
  Port (
    clk_dec, clk_reg : in STD_LOGIC;
    JA : inout STD_LOGIC_VECTOR(7 downto 0);
    RESET_REG : in STD_LOGIC;
    LD, LD_UC : in STD_LOGIC;
    OUTPUT : inout STD_LOGIC_VECTOR(15 downto 0) := x"FFFF";
    SEL : out STD_LOGIC_VECTOR(3 downto 0);
    O_citit : inout STD_LOGIC_VECTOR(3 downto 0)
       );
end component;

component Debouncer is
    Port (
        button_in : in STD_LOGIC;
        button_out : out STD_LOGIC;
        clk, RESET : in STD_LOGIC
    
    );
 end component;
component Display_Unit is
  Port (
    INPUT0, INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, INPUT6, INPUT7, INPUT8, INPUT9, INPUT10, INPUT11, INPUT12, INPUT13, INPUT14, INPUT15 : in STD_LOGIC_VECTOR(15 downto 0);
    an : out STD_LOGIC_VECTOR(3 downto 0);
    seg : out STD_LOGIC_VECTOR(6 downto 0);
    SEL : in STD_LOGIC_VECTOR(3downto 0);
    clk : in STD_LOGIC
   );
end component;

component REG_pin_money is
  Port (
    DATA : in STD_LOGIC_VECTOR(31 downto 0);
    RESET, LD, clk: in STD_LOGIC;
    O : out STD_LOGIC_VECTOR(31 downto 0)
       );
end component;

component freq_div IS
 PORT (
  	clk, RESET : IN STD_LOGIC;
 	new_clk : OUT STD_LOGIC
  );
end component;

signal sig_sel : STD_LOGIC_VECTOR(3 downto 0);
signal SEL_OP_extended : STD_LOGIC_VECTOR(15 downto 0) := x"FFFF";
signal sig_sel_extended : STD_LOGIC_VECTOR(15 downto 0) := x"FFFF";
signal read_out : STD_LOGIC_VECTOR(15 downto 0);
signal block_in : STD_LOGIC_VECTOR(31 downto 0);
signal block_out : STD_LOGIC_VECTOR(31 downto 0);
signal LD_REG_bl : STD_LOGIC;
signal less : STD_LOGIC;
signal sum_pin_out : STD_LOGIC_VECTOR(31 downto 0);
--signal OK_BUT : STD_LOGIC;
signal i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15 : STD_LOGIC_VECTOR(15 downto 0) := x"FFFF";
signal new_clock : STD_LOGIC;
signal cif_curr : STD_LOGIC_VECTOR(3 downto 0) := x"F";
signal RESET_curr_cif : STD_LOGIC;
signal afis_pin : STD_LOGIC_VECTOR(15 downto 0);
begin
    
    freq_divider : freq_div port map (clk => clk, RESET => RESET_BUT, new_clk => new_clock);
    new_clock_out <= new_clock;
   -- DEB_START : Debouncer port map(clk => new_clock, RESET => RESET_BUT, button_in => START_BUT_in, button_out => START_BUT);
   -- DEB_OK : Debouncer port map(clk => new_clock, RESET => RESET_BUT, button_in => OK_BUT_in, button_out => OK_BUT);
    C0 : Read_module port map (clk_reg => new_clock, clk_dec => clk, JA => JA, RESET_REG => RESET_BUT, LD => LD, LD_UC => LD_UC, SEL => sig_sel, OUTPUT => read_out, O_citit => cif_curr);
    C1 : CU port map(START => START_BUT, OK => OK_BUT, RESET => RESET_BUT, clk => new_clock, SEL_OP => SEL_OP, LD_UC => LD_UC, LD => LD, LD_mem_pin => LD_mem_pin, LD_REG_sum => LD_REG_sum, LD_ThN => LD_ThN, LD_HN => LD_HN, LD_TN => LD_TN, LD_UN => LD_UN, CORRECT_PIN => CORRECT_PIN, LD_REG_block => LD_REG_bl, Display_controller_sel => Display_controller_sel, aici => aici, idle_led => idle_led);-- CARD => card, PIN => pin);
    interog <= LD_REG_sum;
    C2 : REG_Block port map (DATA_in => block_in, SEL => sig_sel(2 downto 0), RESET => RESET_BUT, LD_REG_block => LD_REG_bl, clk => clk, DATA_out => block_out);
    C3 : REG_pin_money port map(DATA => block_out, RESET => RESET_BUT, LD => LD_REG_sum, clk => clk, O => sum_pin_out);
    C4 : comparatorBCD port map (N1 => block_out(15 downto 0), N2 => read_out, EQ => CORRECT_PIN, L => less);
    
  
    
    sig_sel_extended(3 downto 0) <= cif_curr;
    SEL_OP_extended(1 downto 0) <= SEL_OP;
    afis_pin <= read_out(11 downto 0) & cif_curr;
    C5 : Display_Unit port map ( INPUT0 => sig_sel_extended, INPUT1 => afis_pin, INPUT2 => SEL_OP_extended, INPUT3 => sum_pin_out(31 downto 16), INPUT4 => i4, INPUT5 => i5, INPUT6 => i6, INPUT7 => i7, INPUT8 => i8, INPUT9 => i9, INPUT10 => i10, INPUT11 => i11, INPUT12 => i12, INPUT13 => i13, INPUT14 => i14, INPUT15 => i15, SEL => Display_controller_sel, clk => clk, an => an, seg => seg);
    
end Behavioral;
