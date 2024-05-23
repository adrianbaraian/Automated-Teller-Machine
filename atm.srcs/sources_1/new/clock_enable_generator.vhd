----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2023 05:04:58 PM
-- Design Name: 
-- Module Name: Debouncer - arch_Debouncer
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity clock_enable_generator is
  Port (
    slow_clk_enable : out STD_LOGIC;
    clk : in STD_LOGIC
   );
end clock_enable_generator;

architecture arch_clock_enable_generator of clock_enable_generator is

begin
 d_ff_clock_enable:
    process(clk)
    variable counter : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
begin
if(rising_edge(clk)) then
    counter := counter + 1;
end if;
  slow_clk_enable <= counter(17);
  end process;
        

end arch_clock_enable_generator;
