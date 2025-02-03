# -------------------------------------------------------------------------------------------------
# -- Project             : Mars ZX2 Reference Design
# -- File description    : Pin assignment and timing constraints file for Mars PM3
# -- File name           : MarsZX2_PM3.xdc
# -- Authors             : Gian Koeppel
# -------------------------------------------------------------------------------------------------
# -- Copyright (c) 2017 by Enclustra GmbH, Switzerland. All rights are reserved.
# -- Unauthorized duplication of this document, in whole or in part, by any means is prohibited
# -- without the prior written permission of Enclustra GmbH, Switzerland.
# --
# -- Although Enclustra GmbH believes that the information included in this publication is correct
# -- as of the date of publication, Enclustra GmbH reserves the right to make changes at any time
# -- without notice.
# --
# -- All information in this document may only be published by Enclustra GmbH, Switzerland.
# -------------------------------------------------------------------------------------------------
# -- Notes:
# -- The IO standards might need to be adapted to your design
# -------------------------------------------------------------------------------------------------
# -- File history:
# --
# -- Version | Date       | Author             | Remarks
# -- ----------------------------------------------------------------------------------------------
# -- 1.0     | 07.05.2015 | G. Koeppel         | First released version
# -- 2.0     | 20.10.2017 | D. Ungureanu       | Consistency checks
# --
# -------------------------------------------------------------------------------------------------

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# ----------------------------------------------------------------------------------
# Important! Do not remove this constraint!
# This property ensures that all unused pins are set to high impedance.
# If the constraint is removed, all unused pins have to be set to HiZ in the top level file.
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLNONE [current_design]
# ----------------------------------------------------------------------------------

set_property BITSTREAM.CONFIG.OVERTEMPPOWERDOWN ENABLE [current_design]

# ----------------------------------------------------------------------------------
# -- Some I/Os are available only on XC7Z020
# -- Uncomment the constraints for these pins when you want to use them
# ----------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------
# -- I/Os connected in parallel with MIO pins, set to high impedance if not used
# -- Available only on XC7Z020
# ----------------------------------------------------------------------------------

# set_property PACKAGE_PIN V5 [get_ports ETH_Link]
# set_property IOSTANDARD LVCMOS33 [get_ports ETH_Link]
#
#set_property PACKAGE_PIN J18 [get_ports CLK]
#set_property IOSTANDARD LVCMOS33 [get_ports CLK]


# MIO 40-51 used for FX3 interface

# ----------------------------------------------------------------------------------
# -- LEDs
# ----------------------------------------------------------------------------------

set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports {Led_N[0]}]
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS33} [get_ports {Led_N[1]}]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {Led_N[2]}]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {Led_N[3]}]

# ------------------------------------------------
# -- B Specific
# ------------------------------------------------

set_property PACKAGE_PIN R17 [get_ports sdi0_cdn]
set_property IOSTANDARD LVCMOS33 [get_ports sdi0_cdn]
set_property PULLUP true [get_ports sdi0_cdn]

set_property -dict {PACKAGE_PIN N20 IOSTANDARD TMDS_33} [get_ports TMDS_clk_p]
set_property -dict {PACKAGE_PIN P20 IOSTANDARD TMDS_33} [get_ports TMDS_clk_n]
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[0]}]
set_property -dict {PACKAGE_PIN Y19 IOSTANDARD TMDS_33} [get_ports {TMDS_data_n[0]}]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[1]}]
set_property -dict {PACKAGE_PIN Y17 IOSTANDARD TMDS_33} [get_ports {TMDS_data_n[1]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD TMDS_33} [get_ports {TMDS_data_p[2]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD TMDS_33} [get_ports {TMDS_data_n[2]}]

set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {DIO[0]}]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {DIO[1]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {DIO[2]}]
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {DIO[3]}]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports {DIO[4]}]
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports {DIO[5]}]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {DIO[6]}]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {DIO[7]}]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports {DIO[8]}]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports {DIO[9]}]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {DIO[10]}]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports {DIO[11]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS33} [get_ports {DIO[12]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports {DIO[13]}]
set_property -dict {PACKAGE_PIN B19 IOSTANDARD LVCMOS33} [get_ports {DIO[14]}]
set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports {DIO[15]}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {DIO[16]}]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {DIO[17]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {DIO[18]}]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {DIO[19]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {DIO[20]}]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports {DIO[21]}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {DIO[22]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {DIO[23]}]

set_property -dict {PACKAGE_PIN U20 IOSTANDARD LVCMOS33} [get_ports J3_5]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports J3_6]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports J3_7]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports J3_8]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports J3_9]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports J3_10]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports J3_11]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports J3_12]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports J3_13]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports J3_14]
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports J3_15]
set_property -dict {PACKAGE_PIN V20 IOSTANDARD LVCMOS33} [get_ports J3_16]
set_property -dict {PACKAGE_PIN W20 IOSTANDARD LVCMOS33} [get_ports J3_17]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports J3_18]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports J3_19]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports J3_20]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports J3_21]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports J3_22]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports J3_23]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports J3_24]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports J3_25]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports J3_26]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports J3_27]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports J3_28]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports J3_29]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports J3_30]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports J3_31]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports J3_32]
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports J3_33]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports J3_34]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports J3_35]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports J3_36]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports J3_37]
set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports J3_38]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports J3_39]

set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVCMOS33} [get_ports J4_14]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports J4_15]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports J4_16]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports J4_17]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports J4_19]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports J4_20]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports J4_21]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports J4_22]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports J4_23]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports J4_24]
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports J4_25]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports J4_26]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports J4_28]
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports J4_29]
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports J4_30]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports J4_31]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports J4_32]
set_property -dict {PACKAGE_PIN H20 IOSTANDARD LVCMOS33} [get_ports J4_34]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports J4_35]
set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports J4_36]
set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS33} [get_ports J4_37]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports J4_38]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports J4_39]

set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports clk_25mhz]

set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {prog_clk[0]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {prog_clk[1]}]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {prog_clk[2]}]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {prog_clk[3]}]


# ----------------------------------------------------------------------------------
# -- i2-port
# ----------------------------------------------------------------------------------
# -- Available only on XC7Z020

#set_property PACKAGE_PIN W8 [get_ports I2C0_SDA]
#set_property IOSTANDARD LVCMOS33 [get_ports I2C0_SDA]
#set_property PULLUP true [get_ports I2C0_SDA]

#set_property PACKAGE_PIN V8 [get_ports I2C0_SCL]
#set_property IOSTANDARD LVCMOS33 [get_ports I2C0_SCL]
#set_property PULLUP true [get_ports I2C0_SCL]

#set_property PACKAGE_PIN Y6 [get_ports I2C0_INT_N]
#set_property IOSTANDARD LVCMOS33 [get_ports I2C0_INT_N]
#set_property PULLUP true [get_ports I2C0_INT_N]


# ----------------------------------------------------------------------------------
# -- UART
# ----------------------------------------------------------------------------------

# USE MIO pins

# ----------------------------------------------------------------------------------
# -- timing constraints
# ----------------------------------------------------------------------------------


create_clock -period 15.000 -name PROG_CLK_0 [get_ports {prog_clk[0]}]
create_clock -period 15.000 -name PROG_CLK_1 [get_ports {prog_clk[1]}]

set_false_path -from [get_clocks -of_objects [get_pins i_system/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks PROG_CLK_1]
set_false_path -from [get_clocks -of_objects [get_pins i_system/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks PROG_CLK_0]
set_false_path -from [get_clocks PROG_CLK_0] -to [get_clocks -of_objects [get_pins i_system/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks PROG_CLK_1] -to [get_clocks -of_objects [get_pins i_system/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {DIO_IBUF[0]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {DIO_IBUF_BUFG[0]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {DIO_IBUF[2]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {DIO_IBUF_BUFG[2]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {DIO_IBUF[4]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {DIO_IBUF_BUFG[4]}]


set_false_path -from [get_clocks -of_objects [get_pins i_system/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks -of_objects [get_pins i_system/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]

create_clock -period 40.000 -name dac_sclko [get_ports J3_13]

set_input_delay -4 -clock dac_sclko -min [get_ports J3_5]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_5]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_5] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_5] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_6]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_6]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_6] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_6] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_7]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_7]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_7] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_7] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_8]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_8]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_8] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_8] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_9]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_9]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_9] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_9] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_10]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_10]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_10] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_10] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_11]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_11]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_11] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_11] -add_delay

set_input_delay -4 -clock dac_sclko -min [get_ports J3_12]
set_input_delay 4 -clock dac_sclko -max [get_ports J3_12]
set_input_delay -4 -clock dac_sclko -min -clock_fall [get_ports J3_12] -add_delay
set_input_delay 4 -clock dac_sclko -max -clock_fall [get_ports J3_12] -add_delay


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets J3_13_IBUF] 