-------------------------------
-- Miriam Ortega Bustos
-- Febrero 2025
-- Component: ADC DRIVER
-------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library xil_defaultlib;
use xil_defaultlib.ltc2358_pkg.all;

entity ltc2358clx is
    generic (
        use_scko:           boolean:= false --always false!, data_out with scki
    );
	port (
		clk: 				in std_logic;             
		rst: 			    in std_logic;
        --clk_rx:             in std_logic;   -- only if use_scko = true
		trig:				in std_logic;
		adc_sclk_o:		    in std_logic;				
		adc_sdo:			in std_logic_vector(7 downto 0);
		adc_busy:		    in std_logic;
		adc_cs:			    out std_logic;
		adc_sclk_i:		    out std_logic;                                       
		adc_cnv:			out std_logic;                                     
		adc_sdi:			out std_logic;                              
		adc_data:		    out a8sv16;
		adc_data_avg:       out a8sv16;
		adc_config: 	    in std_logic_vector(23 downto 0)			
	);
end entity ltc2358clx;
	
architecture rtl of ltc2358clx is

    type t_adc_stage is (ADC_IDLE, ADC_START, ADC_WAIT_END_CONV, ADC_CLK_LO, ADC_CLK_HI, ADC_END, ADC_TRANSFER);
    signal adc_stage: t_adc_stage;

    subtype sv12 is std_logic_vector(11 downto 0);
    type t_sr is array(7 downto 0) of sv12;
    
    signal s_adc_sdo:			std_logic_vector(7 downto 0);
    signal s_adc_sclk_o: 	std_logic;
    signal s_temp_adc_data: a8sv24;
    signal s_temp_adc_data_scko: a8sv24;
    
    signal s_adc_data:  a8sv16;
    signal s_adc_avg:   a8sv16;    
    
	signal s_adc_sdo_re:		a8sv12;
	signal s_adc_sdo_fe:		a8sv12;
    
    signal s_adc_cs:    std_logic;

begin

process(clk, rst)
	variable sscode: std_logic_vector(23 downto 0);
	variable count: integer range 0 to 31;
	begin
		if rst = '0' then
			adc_cnv <= '0';
			adc_sclk_i <= '0';                
			s_adc_cs <= '1';
			for i in 0 to 7 loop
			     s_adc_data(i) <= (others => '0'); 
			end loop;
			adc_stage <= ADC_IDLE;
		elsif rising_edge(clk) then
			case adc_stage is
				when ADC_IDLE =>                -- Conversion starts
					 if trig = '1' then 
						  adc_cnv <= '1';
						  adc_stage <= ADC_START;
						  count:= 5;
					 end if;
					 
				when ADC_START =>               -- CNV TO 0, wait 5 clk
					 if count > 0 then
						  count:= count - 1;
					 else
						  adc_cnv <= '0';
						  count:= 5;
						  adc_stage <= ADC_WAIT_END_CONV;
					 end if;
				
				when ADC_WAIT_END_CONV =>       -- Wait until conversion finish   
					 if adc_busy = '0' then
						  if count = 0 then
								sscode:= adc_config;
								count:= 24;
								s_adc_cs <= '0';
								adc_stage <= ADC_CLK_HI;
						  else 
								count:= count - 1;
						  end if;
					 else
						  count:= 5;
					 end if;
					 
				when ADC_CLK_LO =>              -- Write configuration Softspan
					 if count > 0 then
						  adc_sclk_i <= '1';
						  count:= count - 1;
						  adc_stage <= ADC_CLK_HI;	
                          if not use_scko then 
                            for i in 0 to 7 loop
                                s_temp_adc_data(i) <= s_temp_adc_data(i)(22 downto 0) & adc_sdo(i);
                            end loop;
                          end if;
					 else
						  adc_stage <= ADC_END;
					 end if;
					 
				when ADC_CLK_HI =>              -- Write configuration Softspan
					 adc_sdi <= sscode(23);
					 sscode:= sscode(22 downto 0) & '0';
					 adc_sclk_i <= '0';
					 adc_stage <= ADC_CLK_LO;
				 					 
				when ADC_END =>                 -- Indicates the ending of the configuration softspan
					 s_adc_cs <= '1';
					 count:= 5;
					 adc_stage <= ADC_TRANSFER;
					 
				when ADC_TRANSFER =>            --Transference of the conversion results
					if count > 0 then
						count:= count - 1;
					else
						for i in 0 to 7 loop
						--and (s_temp_adc_data(i)(5 downto 3) = std_logic_vector(to_unsigned(i, 3))) 
					       --if (s_temp_adc_data(i)(2 downto 0) = adc_config(2+3*i downto 3*i)) then 
					       --Check if softspan and ch are correct
						      s_adc_data(i) <= s_temp_adc_data(i)(23 downto 8);
						   --end if;
						end loop;
						adc_stage <= ADC_IDLE;
					end if;
				 
				when others =>
					 adc_stage <= ADC_IDLE;
					 
			end case;
		end if;
	end process;
    
-- Averaging of the conversion results
process(clk, rst)
variable avg_ctr: integer range 0 to 255;
variable accum: a8s24;
    begin
        if rst = '0' then
            for i in 0 to 7 loop
				accum(i) := (others => '0');    
				s_adc_avg(i) <= (others => '0');
			end loop;
			avg_ctr := 0;   
        elsif rising_edge(clk) then
            if trig = '1' then
                if avg_ctr = 255 then    										
                     avg_ctr := 0;
                     for i in 0 to 7 loop 
                        s_adc_avg(i) <= std_logic_vector(accum(i)(23 downto 8));
                        if s_adc_data(i)(15) = '1' then 
                            accum(i) := "11111111" & signed(s_adc_data(i));
                        else
                            accum(i) := "00000000" & signed(s_adc_data(i));
                        end if;						
                    end loop;
                else
                    avg_ctr := avg_ctr + 1;				
                    for i in 0 to 7 loop 
                        accum(i) := accum(i) + signed(s_adc_data(i));
                    end loop;
                end if;
            end if;
		end if;		
    end process;
    
-- Transmision bit a bit of SDO
 process(adc_sclk_o)
	begin
		if rising_edge(adc_sclk_o) then
			for i in 0 to 7 loop
				s_adc_sdo_re(i) <= s_adc_sdo_re(i)(10 downto 0) & adc_sdo(i);
			end loop;
		end if;
	end process;
	
process(adc_sclk_o)
	begin
		if falling_edge(adc_sclk_o) then
			for i in 0 to 7 loop
				s_adc_sdo_fe(i) <= s_adc_sdo_fe(i)(10 downto 0) & adc_sdo(i);
			end loop;
		end if;
	end process;	
	
c1: for i in 0 to 7 generate
	c2: for j in 0 to 11 generate
			s_temp_adc_data(i)(2*j+1) <= s_adc_sdo_re(i)(j);
			s_temp_adc_data(i)(2*j) <= s_adc_sdo_fe(i)(j);
		end generate;
end generate;	
    

adc_cs <= s_adc_cs;	
adc_data <= s_adc_data;
adc_data_avg <= s_adc_avg;
	
end architecture rtl; -- of adc_contr