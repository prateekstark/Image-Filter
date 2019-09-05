library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clocks is
    Port(
           clk : in STD_LOGIC;
           tx_clk : out STD_LOGIC;
           rx_clk : out STD_LOGIC);
end Clocks;

architecture Behavioral of Clocks is
signal temp_rxclk: STD_LOGIC:='0';
signal bit_count1: integer range 0 to 5207 := 0;
signal temp_txclk: STD_LOGIC:='0';
signal bit_count2: integer range 0 to 325 := 0;
begin

--Receiver Clock with 16x Baud Rate
process(clk)
begin
    if(clk='1' and clk'EVENT)then
        if(bit_count2<325)then
            bit_count2 <= bit_count2 + 1;
        else
            bit_count2 <= 0;
            temp_rxclk<=not(temp_rxclk);
        end if;
    end if;
end process;

--Transmitter Clock at 1/16 rate at that of rxclk
process(clk)
begin
    if(clk='1' and clk'EVENT)then
        if(bit_count1<5207)then
            bit_count1<=bit_count1 + 1;
        else
            bit_count1<=0;
            temp_txclk<=not(temp_txclk);
        end if;
    end if;
end process;

--Assignments for clock
rx_clk<=temp_rxclk;    
tx_clk<=temp_txclk;

end Behavioral;