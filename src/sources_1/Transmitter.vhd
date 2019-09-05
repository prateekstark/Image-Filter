library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Transmitter is
Port(
        reset,tx_clk,ld_tx,tx_en,enb: in std_logic;
        tx_data: in std_logic_vector(7 downto 0);
        tx_empty,tx_out: out std_logic
    );
end transmitter;
-- bit_count represents various states of transmitter while loading data

architecture Behavioral of Transmitter is
    type possible_states is (Idle, Start, Data,Stop);
    signal curr_state : possible_states := Idle;
    signal b : integer range 0 to 7 := 0;  
    signal int_reg   : std_logic_vector(7 downto 0) := (others => '0');
begin   
    process (tx_clk, reset)
    begin
        if (reset='1' ) then
            curr_state <= Idle;
            tx_out<='1';
            tx_out<='1';
            tx_empty<='1';    
        elsif tx_clk='1' and tx_clk'EVENT then
            if (tx_en='1') then   
                case curr_state is
 
                    when Idle =>
                        tx_empty <= '1';
                        tx_out <= '1';         
                        b <= 0;
                        if ld_tx = '0' then
                            curr_state <= Idle;
                        else
                            tx_empty <= '0';
                            int_reg <= tx_data;
                            curr_state <= Start;  
                        end if;
 
                    when Start =>
                        tx_out <= '0';
                        curr_state <= Data;         
  
                    when Data =>
                        tx_out <= int_reg(b);
                        if b < 7 then
                            b <= b + 1;
                            curr_state <= Data;
                        else
                            b <= 0;
                            curr_state <= Stop;
                        end if;

                    when Stop =>
                        tx_out <= '1';
                        curr_state <= Idle; 
                        
                    when others =>
                        curr_state <= Idle;
                end case;
            end if;
        end if;
    end process; 
end Behavioral;