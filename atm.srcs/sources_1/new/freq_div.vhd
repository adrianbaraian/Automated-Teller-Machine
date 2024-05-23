LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE ieee.std_logic_unsigned.all;

ENTITY freq_div IS
  PORT (
  	clk, RESET : IN STD_LOGIC;
  	new_clk : OUT STD_LOGIC
  );
END freq_div;


ARCHITECTURE arch_freq_div OF freq_div IS
BEGIN

	process(clk)
		variable NR : std_logic_vector(26 downto 0) := (others => '0');
		begin
			if rising_edge(clk) then
				if RESET = '1' then NR := (others => '0');
				else NR := NR + 1;
				end if;
				end if;
		new_clk <= NR(26);
	end process;
					

END arch_freq_div;
