library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Shifting_REG is
  Port ( 
    DATA_in : in STD_LOGIC_VECTOR(3 downto 0);
    DATA_out : inout STD_LOGIC_VECTOR(11 downto 0);
    SHIFT, RESET, clk : in STD_LOGIC
  );
end Shifting_REG;

architecture Behavioral of Shifting_REG is
begin

    process(clk, RESET, SHIFT)
    begin
        if(RESET = '1') then
            DATA_out <= x"FFF";
        elsif(RESET = '0' and SHIFT = '1') then
            if(rising_edge(clk)) then
                DATA_out <= DATA_out(7 downto 0) & DATA_in;
            end if;
        end if;
        
    end process;
end Behavioral;
