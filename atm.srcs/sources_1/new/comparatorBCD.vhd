library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity comparatorBCD is
      Port (
       N1, N2 : in STD_LOGIC_VECTOR(15 downto 0);
       EQ, L : out STD_LOGIC    
       );
end comparatorBCD;

architecture Behavioral of comparatorBCD is

begin
    process(N1, N2)
    variable N1_int, N2_int : integer;
    begin
        N1_int := 1000*To_Integer(unsigned(N1(15 downto 12))) + 100*To_Integer(unsigned(N1(11 downto 8))) + 10*To_Integer(unsigned(N1(7 downto 4))) + To_Integer(unsigned(N1(3 downto 0)));
        N2_int := 1000*To_Integer(unsigned(N2(15 downto 12))) + 100*To_Integer(unsigned(N2(11 downto 8))) + 10*To_Integer(unsigned(N2(7 downto 4))) + To_Integer(unsigned(N2(3 downto 0)));
        --
		EQ <= '0'; L <= '0';
        --
        if(N1_int /= N2_int) then
            if(N1_int < N2_int) then
                L <= '1';
                else L <= '0';
            end if;
        else EQ <= '1';
        end if;
    end process;

end Behavioral;
