library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity Receiver is
Port(
       rxclk,reset,uld_rx,rx_en,rx_in: in std_logic;
       rx_empty: out std_logic;
       rx_data: out std_logic_vector(7 downto 0)
);
end entity;

architecture Behavioral of receiver is
signal cycle_count:integer range 0 to 15 := 0;
signal mini_cycle_count: integer range 0 to 8 := 0 ;
signal bit_count: integer range 0 to 8 :=0;
signal rec_data: std_logic_vector(7 downto 0) := "00000000";
signal is_empty: std_logic := '1';
signal d: std_logic := '0';

begin
    rx_empty <= is_empty;

    process(rxclk)
    begin
        if(rxclk = '1' and rxclk'event) then
            if(reset = '1') then
            --Initailizing all values
                rx_data <= "00000000";
                is_empty <= '1';
                d <= '0';
                rec_data <= "00000000";
                bit_count <= 0;
                mini_cycle_count <= 0;
                cycle_count <= 0;
            -- main body    
            else if(rx_in = '0' and rx_en = '1' and d ='0') then
                    mini_cycle_Count <= mini_cycle_Count + 1;
                else 
                    mini_cycle_Count <= 0;
                end if;
                
                if(mini_cycle_Count = 8) then    
                   d <= '1';
                   mini_cycle_Count <= 0; 
                end if;
                
                if(rx_en ='1' and d = '1') then  
                    cycle_Count <= cycle_Count +1;
                end if;
                
                if(cycle_Count = 15 and rx_en = '1' and d = '1') then
                    bit_count <= bit_count +1;
                    --Insert the data bits
                    rec_data(bit_count) <= rx_in;
                    cycle_Count <= 0;
                end if;
                
                if(bit_count = 8 and d = '1') then 
                    is_empty <= '0';
                    d <= '0';
                    bit_count <= 0;
                    mini_cycle_Count <= 0;
                    cycle_Count <= 0;
                end if;
                
                if(uld_rx ='1' ) then 
                    rx_data <= rec_data;
                    is_empty <= '1';
                end if;
                
            end if; 
        end if ; 
    end process;                
         
end Behavioral;