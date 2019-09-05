library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Timing is
Port(
    tx_empty,rx_empty,reset,clk: in std_logic;
    uld_rx,ld_tx: out std_logic;
    addra: out integer range 0 to 1919;
    addrb: out integer range 0 to 1579;
    wea,enb: out std_logic
);
end Timing;

architecture Behavioral of Timing is
signal unload: std_logic:='0';
signal addra1: integer range 0 to 1919:=0;
signal addrb1: integer range 0 to 1579:=0;
signal load: std_logic:= '0' ;
signal receive: integer:=0;
begin
process(clk)
begin 
    if(rising_edge(clk)) then
        if(reset='1') then
        --Initializing all default values
            uld_rx<='0';
            unload<='0' ;
            ld_tx<='1';
            load<='1';
            addra<=0;
            addrb<=0;
            addrb1<=0;
            addra1<=0;
            wea<='0';
            enb<='0';
        else 
            if(rx_empty='0' and unload = '0') then
                addra1<=addra1+1;
                addra<=addra1;
                wea<='1';
                unload<='1';
                uld_rx<='1';
                receive<=0 ;
            else wea<='1' ;
                uld_rx<='0';
                unload<='0';
                addra<=addra1 ;    
            end if;
        if(tx_empty='1' and load='0' and receive<1920 and addra1/=addrb1)then
            ld_tx<='1';
            load<='1';
            addrb1<=addrb1+1;
            addrb<=addrb1;
            enb<='1';
            receive<=receive+1 ;
        elsif(tx_empty='0') then
            ld_tx<='0';
            load<='0';
            enb<='0';
            addrb<=addrb1;
        end if;
    end if;
end if ;
end process;
end Behavioral;