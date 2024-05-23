
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Display_controller IS
  PORT (    
    BCD_IN : in STD_LOGIC_VECTOR(15 downto 0);
  	an : out STD_LOGIC_VECTOR (3 DOWNTO 0);
  	clk : in STD_LOGIC;
  	seg : out STD_LOGIC_VECTOR(6 downto 0);
  	RESET : in STD_LOGIC
    );
END Display_controller;



ARCHITECTURE behavioral OF Display_controller IS
	signal Th, H, T, U : STD_LOGIC_VECTOR(3 downto 0);
	signal LED_ACTIVATOR : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal decode : STD_LOGIC_VECTOR(3 downto 0);
BEGIN
    
        process(decode)
        begin
            case decode is
                when "0000" => seg <= "0000001";
                when "0001" => seg <= "1001111";
                when "0010" => seg <= "0010010";
                when "0011" => seg <= "0000110";
                when "0100" => seg <= "1001100";
                when "0101" => seg <= "0100100";
                when "0110" => seg <= "0100000";
                when "0111" => seg <= "0001111";
                when "1000" => seg <= "0000000";
                when "1001" => seg <= "0000100";
                when others => seg <= "1111110";
            end case;
        end process;
    
    	process(clk)
    	variable COUNT : STD_LOGIC_VECTOR(19 DOWNTO 0) := (others => '0');
    	begin
    	if(rising_edge(clk)) then
    	if(RESET = '1') then COUNT := (others => '0');
    	else COUNT := COUNT + 1;
	end if;
	end if;

	LED_ACTIVATOR <= COUNT(19 downto 18);
    	end process;

    	process(LED_ACTIVATOR)
    	begin
	case LED_ACTIVATOR is
	when "00" =>
        an <= "0111";
        decode <= BCD_IN(15 downto 12);
    when "01" =>
        an <= "1011";
        decode <= BCD_IN(11 downto 8);
    when "10" =>
        an <= "1101";
        decode <= BCD_IN(7 downto 4);
    when "11" =>
         an <= "1110";
         decode <= BCD_IN(3 downto 0);
    when others => an <= "ZZZZ";
    seg <= "ZZZZZZZZ";
    end case;  
    	end process;
END behavioral;

