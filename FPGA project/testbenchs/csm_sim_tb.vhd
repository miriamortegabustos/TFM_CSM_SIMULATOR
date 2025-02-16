----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2024 19:23:35
-- Design Name: 
-- Module Name: csm_sim_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

LIBRARY xil_defaultlib;
use xil_defaultlib.ltc2358_pkg.all;

entity csm_sim_tb is
--  Port ( );
end csm_sim_tb;

architecture Behavioral of csm_sim_tb is

component csm_sim is
generic(
  delta_t: integer:= 100 --FPGA period: 100MHz ()
);

  port (

    reset           : in  std_logic;    --Active low
    clk             : in  std_logic;
    valid 		      : in std_logic;
    CURRENT_COIL1	  : in std_logic_vector(15 downto 0); --sin signal
	CURRENT_COIL2     : in std_logic_vector(15 downto 0); --cos signal	
    step_count_prst   : in std_logic;              --    Preset step counter
    prst_val          :in  signed (31 downto 0);                           --  W Preset value for step counter
    adc_th_pos_lo     : in signed (15 downto 0);                      -- RW Threshold Pos lo
	adc_th_pos_hi     : in signed (15 downto 0);                      -- RW Threshold Pos hi
	adc_th_neg_lo   : in signed (15 downto 0);                      -- RW Threshold Neg no
	adc_th_neg_hi   : in signed (15 downto 0);                      -- RW Threshold Pos hi
    mech_end1     : in signed (31 downto 0); 
	mech_end2     : in signed (31 downto 0); 
    forced_rsa      :in std_logic_vector(7 downto 0); -- RW Forced RSA status
    sim_enable : in std_logic_vector(7 downto 0);
    rsa_min     :in a8s32;                             -- RW Min level to set rsa(i)
    rsa_max     :in a8s32;                              -- RW Max level to set rsa(i)
    step_count      : out signed (31 downto 0);                          -- R  Step count
    RSA1              : out std_logic; --Relay Status Acquisition ch 1 to 8
    RSA2              : out std_logic;
    RSA3              : out std_logic;
    RSA4              : out std_logic;
    RSA5              : out std_logic;
    RSA6              : out std_logic;                  
    RSA7              : out std_logic;
    RSA8              : out std_logic
);
end component;
    signal reset            : std_logic:='0';    --Active low
    signal clk              : std_logic;
    signal valid 		      :  std_logic;
    signal CURRENT_COIL1	  :  std_logic_vector(15 downto 0); --sin signal
	signal CURRENT_COIL2     :  std_logic_vector(15 downto 0); --cos signal	
    signal step_count_prst   :  std_logic;              --    Preset step counter
    signal prst_val          :  signed (31 downto 0);                           --  W Preset value for step counter
    signal adc_th_pos_lo     :  signed (15 downto 0);                      -- RW Threshold Pos lo
	signal adc_th_pos_hi     :  signed (15 downto 0);                      -- RW Threshold Pos hi
	signal adc_th_neg_lo   :  signed (15 downto 0);                      -- RW Threshold Neg no
	signal adc_th_neg_hi   :  signed (15 downto 0);                      -- RW Threshold Pos hi
    signal mech_end1     :  signed (31 downto 0); 
	signal mech_end2     :  signed (31 downto 0); 
    signal forced_rsa      : std_logic_vector(7 downto 0); -- RW Forced RSA status
    signal sim_enable :  std_logic_vector(7 downto 0);
    signal rsa_min     : a8s32;                             -- RW Min level to set rsa(i)
    signal rsa_max     : a8s32;                              -- RW Max level to set rsa(i)
    signal step_count      :  signed (31 downto 0);                          -- R  Step count
    signal RSA1              :  std_logic; --Relay Status Acquisition ch 1 to 8
    signal RSA2              :  std_logic;
    signal RSA3              :  std_logic;
    signal RSA4              :  std_logic;
    signal RSA5              :  std_logic;
    signal RSA6              :  std_logic;                  
    signal RSA7              :  std_logic;
    signal RSA8              :  std_logic;

    constant Tclk: time := 100 ns;  -- Clock Period 

begin

csm_simm: csm_sim 
generic map(
  delta_t => 100 --5ns beacuse 200MHz 
)
  port map(
    reset           =>  reset,
    clk             =>  clk,
    valid 		      =>valid,
    CURRENT_COIL1	  =>CURRENT_COIL1,
	CURRENT_COIL2     =>CURRENT_COIL2,	
    step_count_prst   =>step_count_prst,
    prst_val          =>prst_val,
    adc_th_pos_lo     =>adc_th_pos_lo,
	adc_th_pos_hi     =>adc_th_pos_hi,
	adc_th_neg_lo   =>adc_th_neg_lo,
	adc_th_neg_hi   =>adc_th_neg_hi,
    mech_end1     =>mech_end1,
	mech_end2     =>mech_end2,
    forced_rsa     =>forced_rsa,
    sim_enable      =>  sim_enable,
    step_count      =>step_count,
    rsa_min     =>rsa_min,                            -- RW Min level to set rsa(i)
    rsa_max     =>rsa_max,                              -- RW Max level to set rsa(i)
    RSA1              =>RSA1,
    RSA2              =>RSA2,
    RSA3              =>RSA3,
    RSA4              =>RSA4,
    RSA5              =>RSA5,
    RSA6              =>RSA6,               
    RSA7              =>RSA7,
    RSA8              =>RSA8
);

   -- Clock generator
  p_clk : PROCESS
  BEGIN
     Clk <= '1';
     wait for Tclk/2;
     Clk <= '0';
     wait for Tclk/2;
  END PROCESS;

  p_reset : PROCESS
  BEGIN
  -- Initial value
    valid 		      <= '0';
    CURRENT_COIL1	  <= (others => '0');
	CURRENT_COIL2     <= (others => '0');
    step_count_prst   <= '0';
    prst_val          <= (others => '0');
    adc_th_pos_lo     <= (others => '0');
	adc_th_pos_hi     <= (others => '0');
	adc_th_neg_lo     <= (others => '0');
	adc_th_neg_hi     <= (others => '0');
    mech_end1         <= (others => '0');
	mech_end2         <= (others => '0');
	sim_enable        <= (others => '0');
	rsa_min           <= (others=>(others => '0'));
    rsa_max           <= (others=>(others => '0'));
       
--    rsa_min(0) <= to_signed(10, 8);	
    
    reset <= '0';
    wait for 100 ns;
    reset <= '1';
    wait for 100 ns;
   
       
    -- Detect RSA ON 
    adc_th_pos_lo   <= to_signed(4, adc_th_pos_lo'length);
    adc_th_pos_hi   <= to_signed(8, adc_th_pos_hi'length);
    adc_th_neg_lo	<= to_signed(2, adc_th_neg_lo'length);
    adc_th_neg_hi	<= to_signed(1, adc_th_neg_hi'length);

    valid <= '1';
    sim_enable(0) <= '1';
    mech_end1  <= to_signed(1, mech_end1'length);
    mech_end2  <= to_signed(20, mech_end2'length);
    
--    for i in 0 to 7 loop
--        rsa_min(i) <= to_signed(9, rsa_min'length);
--        rsa_max(i) <= to_signed(11, rsa_max'length);
--    end loop;
    
--    rsa_min(0) <= to_signed(9, rsa_min'length);
--    rsa_max(0) <= to_signed(11, rsa_max'length);

    CURRENT_COIL1 <= std_logic_vector(to_signed(10, CURRENT_COIL1'length));
    mech_end1  <= to_signed(1, mech_end1'length);
    mech_end2  <= to_signed(2, mech_end2'length);
    wait for 10*10 ns;
    CURRENT_COIL1 <= std_logic_vector(to_signed(6, CURRENT_COIL1'length));
    wait for 10*10 ns;
    CURRENT_COIL1 <= std_logic_vector(to_signed(10, CURRENT_COIL1'length));
    wait for 10*10 ns;
    CURRENT_COIL1 <= std_logic_vector(to_signed(6, CURRENT_COIL1'length));
    wait for 10*10 ns;
    CURRENT_COIL1 <= std_logic_vector(to_signed(10, CURRENT_COIL1'length));
    wait for 10*80 ns;
    
    wait for 40000 ns;
  end process;  
end Behavioral;
