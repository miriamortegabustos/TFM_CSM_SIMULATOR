library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sadm_det_csm is
	port (
		clk							: in std_logic;             
		reset							: in std_logic;		
		din							: in std_logic_vector(15 downto 0);
		din_valid					: in std_logic;
		--ts 							: in std_logic_vector(63 downto 0);
		adc_th_pos_lo				: in signed(15 downto 0);
		adc_th_pos_hi				: in signed(15 downto 0);
		adc_th_neg_lo				: in signed(15 downto 0);
		adc_th_neg_hi				: in signed(15 downto 0);
		--pulse_din		 			: out std_logic_vector(63 downto 0);
		pulse_wr					: out std_logic_vector(3 downto 0)
	);
end entity sadm_det_csm;


architecture rtl of sadm_det_csm is

type t_input_state is (IN_ZERO, IN_HIGH, IN_LOW);

signal s_input_state:	t_input_state;

constant C_TRANS_ZERO_HIGH: 	std_logic_vector(1 downto 0):= "00";
constant C_TRANS_HIGH_ZERO:   std_logic_vector(1 downto 0):= "01";
constant C_TRANS_ZERO_LOW: 	std_logic_vector(1 downto 0):= "10";
constant C_TRANS_LOW_ZERO: 	std_logic_vector(1 downto 0):= "11";

begin

process(clk, reset)
	begin
		if(reset = '1') then
			pulse_wr <= (others => '0');
			
            s_input_state <= IN_ZERO;

		elsif rising_edge(clk) then
			pulse_wr <= (others => '0');
			if din_valid = '1' then
				case s_input_state is
					when IN_ZERO =>
						if signed(din) > signed(adc_th_pos_hi) then
							s_input_state <= IN_HIGH;
							pulse_wr(0) <= '1';
						elsif signed(din) < signed(adc_th_neg_lo) then
							s_input_state <= IN_LOW;
							pulse_wr(2) <= '1';
						end if;
					when IN_HIGH =>
						if signed(din) < signed(adc_th_pos_lo) then
							s_input_state <= IN_ZERO;
							pulse_wr(1) <= '1';
						end if;
					when IN_LOW =>
						if signed(din) > signed(adc_th_neg_hi) then
							s_input_state <= IN_ZERO;							
							pulse_wr(3) <= '1';
						end if;
					when others =>  s_input_state <= IN_ZERO;

				end case;
			end if;
		end if;
end process;

end architecture rtl;