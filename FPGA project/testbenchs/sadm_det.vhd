----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2024 13:10:40
-- Design Name: 
-- Module Name: sadm_det - Behavioral
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


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sadm_det is
generic(
  delta_t: integer:= 100 --FPGA period: 100MHz ()
);

  port (
    reset           : in  std_logic;    --Active low
    clk             : in  std_logic;
    din				: in std_logic_vector(15 downto 0); --Output current coil of csm motor
    din_valid		: in std_logic; -- Output current coil received is correct
    adc_th_pos_lo   : in signed(15 downto 0); -- Rising edge positive threshold
    adc_th_pos_hi   : in signed(15 downto 0); -- Falling edge positive threshold
    adc_th_neg_lo	: in signed(15 downto 0); -- Rising edge negative threshold
    adc_th_neg_hi	: in signed(15 downto 0); -- Falling edge negative threshold
    pulse_wr        : out std_logic_vector(3 downto 0) -- Pulses of each edge
);
end sadm_det;


architecture behavior of sadm_det is

  ------------------------------------------------------------------------
  -- Signals
  ------------------------------------------------------------------------
  
type t_input_state is (IN_ZERO, IN_HIGH, IN_LOW);
signal s_input_state: t_input_state := IN_ZERO;


constant C_TRANS_ZERO_HIGH: 	std_logic_vector(1 downto 0):= "00";
constant C_TRANS_HIGH_ZERO:   std_logic_vector(1 downto 0):= "01";
constant C_TRANS_ZERO_LOW: 	std_logic_vector(1 downto 0):= "10";
constant C_TRANS_LOW_ZERO: 	std_logic_vector(1 downto 0):= "11";


begin  -- behavior

PROCESS (Clk, Reset) 

BEGIN

    if Reset = '0' then
        pulse_wr <= (others => '0');
        s_input_state <= IN_ZERO;
	elsif Clk'event and Clk = '1' then
        pulse_wr <= (others => '0');
			if din_valid = '1' then
				case s_input_state is
					when IN_ZERO =>
					   pulse_wr(1) <= '0';
					   pulse_wr(3) <= '0';
						if signed(din) > signed(adc_th_pos_hi) then
							s_input_state <= IN_HIGH;
							pulse_wr(0) <= '1';
						elsif signed(din) < signed(adc_th_neg_lo) then
							s_input_state <= IN_LOW;
							pulse_wr(2) <= '1';
						end if;
					when IN_HIGH =>
					   pulse_wr(0) <= '0';
						if signed(din) < signed(adc_th_pos_lo) then
							s_input_state <= IN_ZERO;
							pulse_wr(1) <= '1';
						end if;
					when IN_LOW =>
					   pulse_wr(2) <= '0';
						if signed(din) > signed(adc_th_neg_hi) then
							s_input_state <= IN_ZERO;							
							pulse_wr(3) <= '1';
						end if;
					when others =>
				end case;
			end if;
		end if;

END PROCESS;
 
end behavior;