LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY D_FF IS
  PORT (
  	clk, D, clock_enable: IN STD_LOGIC;
  	Q : OUT STD_LOGIC := '0'
  );
END D_FF;



ARCHITECTURE arch_D_FF OF D_FF IS

BEGIN

	PROCESS(clk)
		BEGIN
			IF rising_edge(clk) then
			 if(clock_enable = '1') then
				 Q <= D;
		      end if;
		end if;
		END PROCESS;

END arch_D_FF;
