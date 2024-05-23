library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity CU is
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
end CU;

architecture arch_CU of CU is
TYPE State_T is (Idle, Read_UC, Read_ThP, Read_HP, Read_TP, Read_UP, Verify_PIN, Sel_trans, Sold, Deposit, Extract, Change_PIN, Read_ThN, Read_HN, Read_TN, Read_UN);
signal curr_state, next_state : State_T := idle;
begin
    update_state:
		process(clk, RESET)
			begin
				if(RESET = '1') then
					curr_state <= idle;
				elsif(rising_edge(clk)) then
					curr_state <= next_state;
				end if;
		end process;

    state_transition:
        process(curr_state, START, OK, RESET, CORRECT_PIN)
            begin
            ---- intialize outputs
            LD_UC <= '0';
             --LD_ThP <= '0'; LD_HP <= '0'; LD_TP <= '0'; LD_UP <= '0';
             LD <= '0';
            LD_mem_pin <= '0';
            LD_REG_sum <= '0'; LD_ThN <= '0'; LD_HN <= '0'; LD_TN <= '0'; LD_UN <= '0'; LD_REG_block <= '0'; aici <= '0'; idle_led <= '0';
            Display_controller_sel <= "1111";
            ----
                case curr_state is
                    when Idle =>
                        idle_led <= '1';
                        if(START = '1') then
                            next_state <= Read_UC;
                        else next_state <= Idle;
                        end if;
                    --reading card number
                    when Read_UC =>
                       -- CARD <= '0';
                        Display_controller_sel <= "0000";
                        if(OK = '1') then
                            LD_UC <= '1';
                            next_state <= Read_ThP;
                        else next_state <= Read_UC;
                        end if;
                    --reading PIN
                    when Read_ThP =>
                     --   PIN <= '0';
                        LD <= '0';
                        Display_controller_sel <= "0001";
                        if(OK = '1') then
                            LD <= '1';
                            next_state <= Read_HP;
                            
                        else next_state <= Read_ThP;
                        end if;
                    when Read_HP =>
                       -- PIN <= '0';
                       LD <= '0';
                        Display_controller_sel <= "0001";
                        if(OK = '1') then
                            LD <= '1';
                            next_state <= Read_TP;
                            
                        else next_state <= Read_HP;
                        end if;
                    when Read_TP =>
                       -- PIN <= '0';
                       LD <= '0';
                        Display_controller_sel <= "0001";
                        if(OK = '1') then
                            LD <= '1';
                            next_state <= Read_UP;
                            
                        else next_state <= Read_TP;
                        end if;
                    when Read_UP =>
                       -- PIN <= '0';
                       LD <= '0';
                        Display_controller_sel <= "0001";
                        if(OK = '1') then
                            LD <= '1';
                            next_state <= Verify_PIN;
                        else next_state <= Read_UP;
                        end if;
                    --verifying if the pin corresponds to the one of the card
                    when Verify_PIN =>
                        LD_mem_pin <= '1';
                        
                        if(CORRECT_PIN = '1') then
                            next_state <= Sel_trans;
                        else 
                            next_state <= Idle;
                        end if;
                    --selection of the transaction wanted
                    when Sel_trans =>
                        aici <= '1';
                        Display_controller_sel <= "0010";
                    	case SEL_OP is
						when "00" =>
							if(OK = '1') then
								next_state <= Sold;
							else next_state <= Sel_trans;
							end if;
						when "01" =>
							if(OK = '1') then
								next_state <= Deposit;
							else next_state <= Sel_trans;
							end if;
						when "10" =>
							if(OK = '1') then
								next_state <= Extract;
							else next_state <= Sel_trans;
							end if;
						when others =>
							if(OK = '1') then
								next_state <= Read_ThN;
							else next_state <= Sel_trans;
							end if;
                    	end case;
                   	--amount of money in account
                  	when Sold =>
                  		LD_REG_sum <= '1';
                  		Display_controller_sel <= "0011";
                  		next_state <= Sold;
                  		--afisare--

                  	--change pin for an account
                  		--reading new
                  	when Read_ThN =>
                        if(OK = '1') then
                            LD_ThN <= '1';
                            next_state <= Read_HN;
                        else next_state <= Read_ThN;
                        end if;
                    when Read_HN =>
                        if(OK = '1') then
                            LD_HN <= '1';
                            next_state <= Read_TN;
                        else next_state <= Read_HN;
                        end if;
                    when Read_TN =>
                        if(OK = '1') then
                            LD_TN <= '1';
                            next_state <= Read_UN;
                        else next_state <= Read_TN;
                        end if;
                    when Read_UN =>
                        if(OK = '1') then
                            LD_UN <= '1';
                            next_state <= Change_PIN;
                        else next_state <= Read_UN;
                        end if;
                    --change the pin of the card
                    when Change_PIN =>
                            LD_REG_block <= '1';
                            
                    --deposit transaction
                   	when Deposit =>

                    --extraction transaction
                   	when Extract =>

                   	
                when others => null;
                end case;        
        end process;
    
end arch_CU;
