--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
--Date        : Tue Jun 18 14:37:05 2024
--Host        : mortega-Precision-M4800 running 64-bit Ubuntu 20.04.6 LTS
--Command     : generate_target MarsZX2_wrapper.bd
--Design      : MarsZX2_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MarsZX2_wrapper is
  port (
    ADC1_BUSY : in STD_LOGIC;
    ADC1_CNV : out STD_LOGIC;
    ADC1_CS : out STD_LOGIC;
    ADC1_SCLKI : out STD_LOGIC;
    ADC1_SCLKO : in STD_LOGIC;
    ADC1_SDI : out STD_LOGIC;
    ADC1_SDO : in STD_LOGIC_VECTOR ( 7 downto 0 );
    COIL1_SEL_1 : out STD_LOGIC;
    COIL1_SEL_2 : out STD_LOGIC;
    COIL1_SEL_SC : out STD_LOGIC;
    COIL2_SEL_1 : out STD_LOGIC;
    COIL2_SEL_2 : out STD_LOGIC;
    COIL2_SEL_SC : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FAN_PWM : out STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    GPIO_I : in STD_LOGIC_VECTOR ( 63 downto 0 );
    GPIO_O : out STD_LOGIC_VECTOR ( 63 downto 0 );
    IRQ_P2F_GPIO : out STD_LOGIC;
    LOAD_SEL_OUT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    RESET_N : out STD_LOGIC;
    RSA1 : out STD_LOGIC;
    RSA2 : out STD_LOGIC;
    RSA3 : out STD_LOGIC;
    RSA4 : out STD_LOGIC;
    RSA5 : out STD_LOGIC;
    RSA6 : out STD_LOGIC;
    RSA7 : out STD_LOGIC;
    RSA8 : out STD_LOGIC;
    SDIO0_CDN : in STD_LOGIC;
    SDIO0_WP : in STD_LOGIC;
    can0_rxd : in STD_LOGIC;
    can0_txd : out STD_LOGIC;
    can1_rxd : in STD_LOGIC;
    can1_txd : out STD_LOGIC;
    clk_25mhz : in STD_LOGIC;
    pps_in : in STD_LOGIC;
    tmds_clk_n : out STD_LOGIC;
    tmds_clk_p : out STD_LOGIC;
    tmds_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    tmds_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    uart1_rxd : in STD_LOGIC;
    uart1_txd : out STD_LOGIC
  );
end MarsZX2_wrapper;

architecture STRUCTURE of MarsZX2_wrapper is
  component MarsZX2 is
  port (
    SDIO0_CDN : in STD_LOGIC;
    SDIO0_WP : in STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    RESET_N : out STD_LOGIC;
    GPIO_I : in STD_LOGIC_VECTOR ( 63 downto 0 );
    GPIO_O : out STD_LOGIC_VECTOR ( 63 downto 0 );
    IRQ_P2F_GPIO : out STD_LOGIC;
    tmds_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    tmds_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    tmds_clk_p : out STD_LOGIC;
    tmds_clk_n : out STD_LOGIC;
    clk_25mhz : in STD_LOGIC;
    pps_in : in STD_LOGIC;
    uart1_rxd : in STD_LOGIC;
    uart1_txd : out STD_LOGIC;
    can0_rxd : in STD_LOGIC;
    can1_rxd : in STD_LOGIC;
    can0_txd : out STD_LOGIC;
    can1_txd : out STD_LOGIC;
    ADC1_SDI : out STD_LOGIC;
    ADC1_CNV : out STD_LOGIC;
    ADC1_CS : out STD_LOGIC;
    ADC1_SCLKI : out STD_LOGIC;
    ADC1_SCLKO : in STD_LOGIC;
    ADC1_BUSY : in STD_LOGIC;
    ADC1_SDO : in STD_LOGIC_VECTOR ( 7 downto 0 );
    RSA1 : out STD_LOGIC;
    RSA2 : out STD_LOGIC;
    RSA3 : out STD_LOGIC;
    RSA4 : out STD_LOGIC;
    RSA5 : out STD_LOGIC;
    RSA6 : out STD_LOGIC;
    RSA7 : out STD_LOGIC;
    RSA8 : out STD_LOGIC;
    LOAD_SEL_OUT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    COIL1_SEL_SC : out STD_LOGIC;
    COIL1_SEL_1 : out STD_LOGIC;
    COIL1_SEL_2 : out STD_LOGIC;
    COIL2_SEL_SC : out STD_LOGIC;
    COIL2_SEL_1 : out STD_LOGIC;
    COIL2_SEL_2 : out STD_LOGIC;
    FAN_PWM : out STD_LOGIC;
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC
  );
  end component MarsZX2;
begin
MarsZX2_i: component MarsZX2
     port map (
      ADC1_BUSY => ADC1_BUSY,
      ADC1_CNV => ADC1_CNV,
      ADC1_CS => ADC1_CS,
      ADC1_SCLKI => ADC1_SCLKI,
      ADC1_SCLKO => ADC1_SCLKO,
      ADC1_SDI => ADC1_SDI,
      ADC1_SDO(7 downto 0) => ADC1_SDO(7 downto 0),
      COIL1_SEL_1 => COIL1_SEL_1,
      COIL1_SEL_2 => COIL1_SEL_2,
      COIL1_SEL_SC => COIL1_SEL_SC,
      COIL2_SEL_1 => COIL2_SEL_1,
      COIL2_SEL_2 => COIL2_SEL_2,
      COIL2_SEL_SC => COIL2_SEL_SC,
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FAN_PWM => FAN_PWM,
      FCLK_CLK0 => FCLK_CLK0,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      GPIO_I(63 downto 0) => GPIO_I(63 downto 0),
      GPIO_O(63 downto 0) => GPIO_O(63 downto 0),
      IRQ_P2F_GPIO => IRQ_P2F_GPIO,
      LOAD_SEL_OUT(2 downto 0) => LOAD_SEL_OUT(2 downto 0),
      RESET_N => RESET_N,
      RSA1 => RSA1,
      RSA2 => RSA2,
      RSA3 => RSA3,
      RSA4 => RSA4,
      RSA5 => RSA5,
      RSA6 => RSA6,
      RSA7 => RSA7,
      RSA8 => RSA8,
      SDIO0_CDN => SDIO0_CDN,
      SDIO0_WP => SDIO0_WP,
      can0_rxd => can0_rxd,
      can0_txd => can0_txd,
      can1_rxd => can1_rxd,
      can1_txd => can1_txd,
      clk_25mhz => clk_25mhz,
      pps_in => pps_in,
      tmds_clk_n => tmds_clk_n,
      tmds_clk_p => tmds_clk_p,
      tmds_data_n(2 downto 0) => tmds_data_n(2 downto 0),
      tmds_data_p(2 downto 0) => tmds_data_p(2 downto 0),
      uart1_rxd => uart1_rxd,
      uart1_txd => uart1_txd
    );
end STRUCTURE;
