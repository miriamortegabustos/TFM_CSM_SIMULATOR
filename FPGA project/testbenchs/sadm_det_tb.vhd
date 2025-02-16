----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2024 13:12:39
-- Design Name: 
-- Module Name: sadm_det_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sadm_det_tb is
--  Port ( );
end sadm_det_tb;

architecture Behavioral of sadm_det_tb is

component sadm_det is
generic(
  delta_t: integer:= 100 --FPGA period: 100MHz ()
);

  port (
    reset           : in  std_logic;    --Active low
    clk             : in  std_logic;
    din				: in std_logic_vector(15 downto 0); --Output current coil of csm motor
    din_valid		: in std_logic; -- Output current coil received is correct
    adc_th_pos_lo   : in signed(15 downto 0); -- Falling edge positive threshold
    adc_th_pos_hi   : in signed(15 downto 0); -- Rising edge positive threshold
    adc_th_neg_lo	: in signed(15 downto 0); -- Falling edge negative threshold
    adc_th_neg_hi	: in signed(15 downto 0); -- Rising edge negative threshold
    pulse_wr        : out std_logic_vector(3 downto 0) -- Pulses of each edge
);
end component;
    signal reset            : std_logic:='0';    --Active low
    signal clk              : std_logic;
    signal din              : std_logic_vector(15 downto 0); --Output current coil of csm motor
    signal din_valid        : std_logic; -- Output current coil received is correct
    signal adc_th_pos_lo    : signed(15 downto 0); -- Rising edge positive threshold
    signal adc_th_pos_hi    : signed(15 downto 0); -- Falling edge positive threshold
    signal adc_th_neg_lo    : signed(15 downto 0); -- Rising edge negative threshold
    signal adc_th_neg_hi    : signed(15 downto 0); -- Falling edge negative threshold
    signal pulse_wr         : std_logic_vector(3 downto 0); -- Pulses of each edge

    constant Tclk: time := 100 ns;  -- Clock Period 

begin

sadm_dett: sadm_det
generic map(
  delta_t => 100 --5ns beacuse 200MHz 
)
  port map(
    reset           =>  reset,
    clk             =>  clk,
    din				=>   din,
    din_valid		=>   din_valid,
    adc_th_pos_lo   =>  adc_th_pos_lo,
    adc_th_pos_hi   =>  adc_th_pos_hi,
    adc_th_neg_lo   =>  adc_th_neg_lo,
    adc_th_neg_hi	=>  adc_th_neg_hi,
    pulse_wr        =>  pulse_wr
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
    din             <= (others =>'0');	
    din_valid		<= '0';
    adc_th_pos_lo   <= (others =>'0');
    adc_th_pos_hi   <= (others =>'0');
    adc_th_neg_lo	<= (others =>'0');
    adc_th_neg_hi	<= (others =>'0');
    
    reset <= '0';
    wait for 100 ns;
    reset <= '1';
    wait for 100 ns;
    
    adc_th_pos_lo   <= to_signed(8, adc_th_pos_lo'length);
    adc_th_pos_hi   <= to_signed(4, adc_th_pos_hi'length); --TODO
    adc_th_neg_lo	<= to_signed(2, adc_th_neg_lo'length);
    adc_th_neg_hi	<= to_signed(1, adc_th_neg_hi'length);
    
    -- Detect a postive risign edge
    din_valid <= '1';   
    din <= std_logic_vector(to_signed(10, din'length));
    wait for 10*10 ns;
    
    -- Detect a postive falling edge  
    din <= std_logic_vector(to_signed(3, din'length));
    wait for 10*10 ns;
    
    -- Detect a negative risign edge
    din <= std_logic_vector(to_signed(0, din'length));
    wait for 10*10 ns;
    
    -- Detect a negative falling edge  
    din <= std_logic_vector(to_signed(3, din'length));
    wait for 10*10 ns;
    
    wait for 40000 ns;
  end process;  
end Behavioral;