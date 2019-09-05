library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity collect is
Port(
        clk,reset: in std_logic;
        tx_en,rx_en,rx_in: in std_logic;
        led1: out std_logic;
        led2: out std_logic;
        led3: out std_logic;
        led4: out std_logic;
        led5: out std_logic;
        led6: out std_logic;
        led7: out std_logic;
        led8: out std_logic;
        tx_out: out std_logic
);
end collect;

architecture Behavioral of collect is
SIGNAL txclk,enb1,wea1: std_logic;
SIGNAL rxclk: std_logic;
signal addra1,addrb1: integer;
SIGNAL uldrx: std_logic;
SIGNAL ldtx: std_logic;
SIGNAL rxempty: std_logic;
SIGNAL txempty: std_logic;
SIGNAL data, dina_temp, doutb1: std_logic_vector(7 downto 0);
begin

Div_Clocks: ENTITY WORK.Clocks(Behavioral) 
PORT MAP (
    clk => clk,
    tx_clk => txclk,
    rx_clk => rxclk
);

Div_Timing: ENTITY WORK.Timing(Behavioral)
PORT MAP(
    tx_empty => txempty,
    rx_empty => rxempty,
    reset => reset,
    clk => rxclk,
    uld_rx => uldrx,
    ld_tx => ldtx,
    addra => addra1,
    addrb => addrb1,
    wea => wea1,
    enb => enb1
);

Div_transmitter: ENTITY WORK.Transmitter(Behavioral)
PORT MAP (
    reset => reset,
    tx_clk => txclk,
    ld_tx => ldtx,
    tx_en => tx_en,
    enb => enb1,
    tx_out => tx_out,
    tx_data => doutb1,
    tx_empty => txempty
);

Div_receiver: ENTITY WORK.Receiver(Behavioral)
PORT MAP(    
    rxclk => rxclk,
    reset => reset,
    uld_rx => uldrx,
    rx_en => rx_en,
    rx_in => rx_in,
    rx_empty => rxempty,
    rx_data => dina_temp
);

Div_Memory: ENTITY WORK.Memory(Behavioral)
PORT MAP(
    reset => reset,
    dina => dina_temp,
    doutb => doutb1,
    addra => addra1,
    addrb => addrb1,
    en => enb1,
    clk => rxclk,
    wea => wea1 
);
--Display on led
led1 <= dina_temp(0);
led2 <= dina_temp(1);
led3 <= dina_temp(2);
led4 <= dina_temp(3);
led5 <= dina_temp(4);
led6 <= dina_temp(5);
led7 <= dina_temp(6);
led8 <= dina_temp(7);

end Behavioral;        
