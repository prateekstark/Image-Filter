# Clock signal
#Bank = 34, Pin name = ,					Sch name = CLK100MHZ
		set_property PACKAGE_PIN W5 [get_ports clk]
		set_property IOSTANDARD LVCMOS33 [get_ports clk]
		create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]
#input switches
set_property PACKAGE_PIN V16 [get_ports tx_en]					
	set_property IOSTANDARD LVCMOS33 [get_ports tx_en]
set_property PACKAGE_PIN V17 [get_ports rx_en]					
	set_property IOSTANDARD LVCMOS33 [get_ports rx_en]
#LED's
set_property PACKAGE_PIN U16 [get_ports led1]			
	set_property IOSTANDARD LVCMOS33 [get_ports led1]
set_property PACKAGE_PIN E19 [get_ports led2]					
	set_property IOSTANDARD LVCMOS33 [get_ports led2]
set_property PACKAGE_PIN U19 [get_ports led3]					
	set_property IOSTANDARD LVCMOS33 [get_ports led3]
set_property PACKAGE_PIN V19 [get_ports led4]					
	set_property IOSTANDARD LVCMOS33 [get_ports led4]
set_property PACKAGE_PIN W18 [get_ports led5]					
    set_property IOSTANDARD LVCMOS33 [get_ports led5]
set_property PACKAGE_PIN U15 [get_ports led6]					
    set_property IOSTANDARD LVCMOS33 [get_ports led6]
set_property PACKAGE_PIN U14 [get_ports led7]					
	set_property IOSTANDARD LVCMOS33 [get_ports led7]
set_property PACKAGE_PIN V14 [get_ports led8]					
	set_property IOSTANDARD LVCMOS33 [get_ports led8]

set_property PACKAGE_PIN U18 [get_ports reset]						
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN B18 [get_ports rx_in]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx_in]
set_property PACKAGE_PIN A18 [get_ports tx_out]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx_out]

# Others (BITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]