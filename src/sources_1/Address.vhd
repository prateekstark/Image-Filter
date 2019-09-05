library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Address is
Port (
        reset : in std_logic;
        wea : in std_logic;
        enb : in std_logic;
        rx_empty : in std_logic;
        tx_empty: in std_logic;
        addra : out integer range 0 to 3 := 0;
        addrb : out integer range 0 to 3 := 0
        );
end Address;

architecture Behavioral of Address is
signal counta , countb: integer range 0 to 3 := 0;
begin
process(rx_empty)
begin
addra <= counta;
addrb <= countb;
end process;
process(reset, rx_empty)
begin
if(reset = '1') then
counta<= 0;
countb <= 0;
else
if(falling_edge(rx_empty)) then
if(wea = '1') then
counta <= counta + 1;
end if;
if(counta = 3) then
counta <= 0;
end if;
end if;
if(falling_edge(tx_empty)) then
if(enb = '1') then
countb <= countb + 1;
end if;
if(countb = 3) then
countb <= 0;
end if;
end if;
end if;
end process;
end Behavioral;