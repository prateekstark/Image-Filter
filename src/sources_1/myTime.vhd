library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity timing_circuit_new is
  Port (
  rxclk: in std_logic;
  reset: in std_logic;
  tx_empty: in std_logic;
  rx_empty: in std_logic;
  uld_rx: out std_logic;
  ld_tx: out std_logic;
  wea : out std_logic;
  enb: out std_logic
   );
end timing_circuit_new;
architecture Behavioral of timing_circuit_new is
signal flag: std_logic;
begin
    process(reset, rxclk)
    begin
        uld_rx <='0';
        wea <= '1';
        enb <= '0'; 
        if(rxclk = '1' and rxclk'event) then
                if(rx_empty = '0') then
                    uld_rx <= '1';
                    wea <= '0';
                 else
                     uld_rx <= '0';
                     wea <= '1';
                 end if;            
                if (tx_empty = '0') then 
                    ld_tx <= '0';
                    enb <= '1';
                else 
                    ld_tx <= '1';
                end if;       
        end if; 
            if(reset = '1') then
                uld_rx<='0';
                ld_tx<='0';
                wea <= '1';
                enb<= '0';
            end if;
    end process;
end Behavioral;