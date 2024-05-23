library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity REG_pin_money is
  Port (
    DATA : in STD_LOGIC_VECTOR(31 downto 0);
    RESET, LD, clk: in STD_LOGIC;
    O : out STD_LOGIC_VECTOR(31 downto 0)
       );
end REG_pin_money;

architecture arch_REG_pin_money of REG_pin_money is

begin
    process(clk, RESET, LD) 
    variable reg_data : STD_LOGIC_VECTOR(31 downto 0) := x"12340011";
        begin
            O <= reg_data;
            if(RESET = '1') then
               reg_data := x"12340011";
               O <= x"12340011";
            elsif(RESET = '0' and LD = '1') then
                if(rising_edge(clk)) then
                    reg_data := DATA;
                    O <= DATA;
                else null;
                end if;
            end if;
    end process;

end arch_REG_pin_money;
