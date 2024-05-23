LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;



ENTITY DMUX_1_to_8 IS
  PORT (
  	INPUT : in STD_LOGIC_VECTOR(31 downto 0);
  	SEL : in STD_LOGIC_VECTOR(2 downto 0);
  	OUTPUT0, OUTPUT1 ,OUTPUT2, OUTPUT3, OUTPUT4, OUTPUT5 ,OUTPUT6, OUTPUT7 : out STD_LOGIC_VECTOR(31 downto 0)
  );
END DMUX_1_to_8;


ARCHITECTURE ARH_DMUX_1_to_8 OF DMUX_1_to_8 IS

BEGIN

    process(SEL, INPUT)
    begin
    OUTPUT0 <= x"00000000"; OUTPUT1 <= x"00000000"; OUTPUT2 <= x"00000000"; OUTPUT3 <= x"00000000";
    OUTPUT4 <= x"00000000"; OUTPUT5 <= x"00000000"; OUTPUT6 <= x"00000000"; OUTPUT7 <= x"00000000";
	case SEL is
	   when "000" => OUTPUT0 <= INPUT;
	   when "001" => OUTPUT1 <= INPUT;
	   when "010" => OUTPUT2 <= INPUT;
	   when "011" => OUTPUT3 <= INPUT;
	   when "100" => OUTPUT4 <= INPUT;
	   when "101" => OUTPUT5 <= INPUT;
	   when "110" => OUTPUT6 <= INPUT;
	   when others => OUTPUT7 <= INPUT;
	end case;
	end process;

END ARH_DMUX_1_to_8;
