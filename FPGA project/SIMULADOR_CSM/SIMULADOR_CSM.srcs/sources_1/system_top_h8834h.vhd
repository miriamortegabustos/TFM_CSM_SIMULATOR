---------------------------------------------------------------------------------------------------
    -- Project          : H8834H
-- File description : Top Level
-- File name        : h8834h_PM3.vhd
---------------------------------------------------------------------------------------------------

-- Miriam Ortega Bustos
-- Febrero 2025
-- System top: SIMULADOR CSM

---------------------------------------------------------------------------------------------------
-- libraries
---------------------------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

library unisim;
	use unisim.vcomponents.all;

entity system_top is
	port (
		DDR_addr			: inout std_logic_vector ( 14 downto 0 );
		DDR_ba				: inout std_logic_vector ( 2 downto 0 );
		DDR_cas_n			: inout std_logic;
		DDR_ck_n			: inout std_logic;
		DDR_ck_p			: inout std_logic;
		DDR_cke				: inout std_logic;
		DDR_cs_n			: inout std_logic;
		DDR_dm				: inout std_logic_vector ( 3 downto 0 );
		DDR_dq				: inout std_logic_vector ( 31 downto 0 );
		DDR_dqs_n			: inout std_logic_vector ( 3 downto 0 );
		DDR_dqs_p			: inout std_logic_vector ( 3 downto 0 );
		DDR_odt				: inout std_logic;
		DDR_ras_n			: inout std_logic;
		DDR_reset_n			: inout std_logic;
		DDR_we_n			: inout std_logic;
		
		FIXED_IO_ddr_vrn	: inout std_logic;
		FIXED_IO_ddr_vrp	: inout std_logic;
		FIXED_IO_mio		: inout std_logic_vector ( 53 downto 0 );
		FIXED_IO_ps_clk		: inout std_logic;
		FIXED_IO_ps_porb	: inout std_logic;
		FIXED_IO_ps_srstb	: inout std_logic;

        TMDS_data_p         : out std_logic_vector(2 downto 0);
        TMDS_data_n         : out std_logic_vector(2 downto 0);
        TMDS_clk_p          : out std_logic;
        TMDS_clk_n          : out std_logic;
        
        DIO                 : inout std_logic_vector(23 downto 0);
        
        J3_5                : inout std_logic;
        J3_6                : inout std_logic;
        J3_7                : inout std_logic;
        J3_8                : inout std_logic;
        J3_9                : inout std_logic;
        J3_10               : inout std_logic;
        J3_11               : inout std_logic;
        J3_12               : inout std_logic;
        J3_13               : inout std_logic;
        J3_14               : inout std_logic;
        J3_15               : inout std_logic;
        J3_16               : inout std_logic;
        J3_17               : inout std_logic;
        J3_18               : inout std_logic;
        J3_19               : inout std_logic;
        J3_20               : inout std_logic;
        J3_21               : inout std_logic;
        J3_22               : inout std_logic;
        J3_23               : inout std_logic;
        J3_24               : inout std_logic;
        J3_25               : inout std_logic;
        J3_26               : inout std_logic;
        J3_27               : inout std_logic;
        J3_28               : inout std_logic;
        J3_29               : inout std_logic;
        J3_30               : inout std_logic;
        J3_31               : inout std_logic;
        J3_32               : inout std_logic;
        J3_33               : inout std_logic;
        J3_34               : inout std_logic;
        J3_35               : inout std_logic;
        J3_36               : inout std_logic;
        J3_37               : inout std_logic;
        J3_38               : inout std_logic;
        J3_39               : inout std_logic;
        
        J4_14               : inout std_logic;
        J4_15               : inout std_logic;
        J4_16               : inout std_logic;
        J4_17               : inout std_logic;
        J4_19               : inout std_logic;
        J4_20               : inout std_logic;
        J4_21               : inout std_logic;
        J4_22               : inout std_logic;
        J4_23               : inout std_logic;
        J4_24               : inout std_logic;
        J4_25               : inout std_logic;
        J4_26               : inout std_logic;
        J4_28               : inout std_logic;
        J4_29               : inout std_logic;
        J4_30               : inout std_logic;
        J4_31               : inout std_logic;
        J4_32               : inout std_logic;
        J4_34               : inout std_logic;
        J4_35               : inout std_logic;
        J4_36               : inout std_logic;
        J4_37               : inout std_logic;
        J4_38               : inout std_logic;
        J4_39               : inout std_logic;
        
        clk_25mhz           : in std_logic;
        prog_clk            : in std_logic_vector(3 downto 0);
        
		Led_N 				: out	std_logic_vector(3 downto 0);

		sdi0_cdn            : in std_logic
	);
end system_top;

architecture structure of system_top is

	component MarsZX2 is
		port (
			DDR_cas_n 			: inout STD_LOGIC;
			DDR_cke 			: inout STD_LOGIC;
			DDR_ck_n 			: inout STD_LOGIC;
			DDR_ck_p 			: inout STD_LOGIC;
			DDR_cs_n 			: inout STD_LOGIC;
			DDR_reset_n 		: inout STD_LOGIC;
			DDR_odt 			: inout STD_LOGIC;
			DDR_ras_n 			: inout STD_LOGIC;
			DDR_we_n 			: inout STD_LOGIC;
			DDR_ba 				: inout STD_LOGIC_VECTOR ( 2 downto 0 );
			DDR_addr 			: inout STD_LOGIC_VECTOR ( 14 downto 0 );
			DDR_dm 				: inout STD_LOGIC_VECTOR ( 3 downto 0 );
			DDR_dq 				: inout STD_LOGIC_VECTOR ( 31 downto 0 );
			DDR_dqs_n 			: inout STD_LOGIC_VECTOR ( 3 downto 0 );
			DDR_dqs_p 			: inout STD_LOGIC_VECTOR ( 3 downto 0 );
			FIXED_IO_mio 		: inout STD_LOGIC_VECTOR ( 53 downto 0 );
			FIXED_IO_ddr_vrn 	: inout STD_LOGIC;
			FIXED_IO_ddr_vrp 	: inout STD_LOGIC;
			FIXED_IO_ps_srstb 	: inout STD_LOGIC;
			FIXED_IO_ps_clk 	: inout STD_LOGIC;
			FIXED_IO_ps_porb 	: inout STD_LOGIC;
			SDIO0_CDN           : in  STD_LOGIC;
			SDIO0_WP            : in  STD_LOGIC;
           
            			            
            GPIO_O              : out std_logic_vector(63 downto 0);
            GPIO_I              : in std_logic_vector(63 downto 0);
                            
            TMDS_data_p         : out std_logic_vector(2 downto 0);
            TMDS_data_n         : out std_logic_vector(2 downto 0);
            TMDS_clk_p          : out std_logic;
            TMDS_clk_n          : out std_logic;
            
            clk_25mhz           : in std_logic;
            
            -- Declaration of all INPUTS and OUTPUTS of the system
                        
            -- INPUTS/OUTPUTS of LTC2358 (ADC)
            ADC1_SCLKO:in std_logic;
            ADC1_SDO:in std_logic_vector(7 downto 0);
            ADC1_BUSY:in std_logic;
            
            ADC1_CS: out std_logic;
            ADC1_SCLKI: out std_logic;
            ADC1_CNV: out std_logic;
            ADC1_SDI: out std_logic;
            
           -- INPUTS/OUTPUTS of CSM INTERFACE
           --Solid State Relays
            RSA1: out std_logic;
            RSA2: out std_logic;
            RSA3: out std_logic;
            RSA4: out std_logic;
            RSA5: out std_logic;
            RSA6: out std_logic;                  
            RSA7: out std_logic;
            RSA8: out std_logic; 
            -- Loads Selection
            COIL1_SEL_SC:   out std_logic; 
            COIL1_SEL_1:    out std_logic; 
            COIL1_SEL_2:    out std_logic; 
            COIL2_SEL_SC:   out std_logic; 
            COIL2_SEL_1:    out std_logic; 
            COIL2_SEL_2:    out std_logic; 
            
            --INPUTS/OUTPUTS of LLD INTERFACE
           LOAD_SEL_OUT: out std_logic_vector(2 downto 0);
           
           -- INPUTS/OUTPUTS of THERMAL CONTROL
           FAN_PWM:     out std_logic;

            RESET_N             : out std_logic;
            FCLK_CLK0           : out std_logic
            
           
    );
	end component MarsZX2;
	
	component iobuf_array is 
            Generic (
                LENGTH: integer:= 16
            );
            Port (
				io_t:       in std_logic_vector(LENGTH-1 downto 0);
				io_o:       in std_logic_vector(LENGTH-1 downto 0);
				io_i:       out std_logic_vector(LENGTH-1 downto 0);
				io:         inout std_logic_vector(LENGTH-1 downto 0)
			);
    end component;
  

	signal IIC_0_sda_i 		: std_logic;
	signal IIC_0_sda_o 		: std_logic;
	signal IIC_0_sda_t 		: std_logic;
	signal IIC_0_scl_i 		: std_logic;
	signal IIC_0_scl_o 		: std_logic;
	signal IIC_0_scl_t 		: std_logic;

	signal Clk				: std_logic;
	signal Rst				: std_logic := '0';
	signal Rst_N 			: std_logic := '1';
	signal ETH_RST			: std_logic := '0';
	
	signal RstCnt			: unsigned (15 downto 0) := (others => '0'); -- 1ms reset for Ethernet PHY
	
	signal LedCount			: unsigned (23 downto 0);
	signal GPIO				: std_logic_vector (7 downto 0);

	signal SDIO0_CDN_s      : std_logic := '0';
	signal SDIO0_WP_s       : std_logic := '1';
	
	signal clk0             : std_logic;
    
    signal s_sdi0_cdn       : std_logic;
        
    signal s_gpio_o:        std_logic_vector(63 downto 0);
    signal s_gpio_i:        std_logic_vector(63 downto 0);
    	
	--Declaration of all signals of the system
	
    -- LTC2358 (ADC)
    signal ADC1_SCLKO: std_logic;
    signal ADC1_SDO: std_logic_vector(7 downto 0);
    signal ADC1_BUSY: std_logic;
    
    signal ADC1_CS:  std_logic;
    signal ADC1_SCLKI:  std_logic;
    signal ADC1_CNV:  std_logic;
    signal ADC1_SDI:  std_logic;
     
    -- CSM INTERFACE
    signal RSA1: std_logic;
    signal RSA2: std_logic;
    signal RSA3: std_logic;
    signal RSA4: std_logic;
    signal RSA5: std_logic;
    signal RSA6: std_logic;                  
    signal RSA7: std_logic;
    signal RSA8: std_logic; 
    
    signal COIL1_SEL_SC:    std_logic; 
    signal COIL1_SEL_1:     std_logic; 
    signal COIL1_SEL_2:     std_logic; 
    signal COIL2_SEL_SC:    std_logic; 
    signal COIL2_SEL_1:     std_logic; 
    signal COIL2_SEL_2:     std_logic; 
    
    --LLD INTERFACE
    signal LOAD_SEL_OUT: std_logic_vector(2 downto 0);
    
    -- THERMAL CONTROL
    signal FAN_PWM: std_logic;

begin


	------------------------------------------------------------------------------------------------
	--	Processing System
	------------------------------------------------------------------------------------------------

	i_system : MarsZX2
		port map (
			DDR_addr			=> DDR_addr,
			DDR_ba				=> DDR_ba,
			DDR_cas_n			=> DDR_cas_n,
			DDR_ck_n			=> DDR_ck_n,
			DDR_ck_p			=> DDR_ck_p,
			DDR_cke				=> DDR_cke,
			DDR_cs_n			=> DDR_cs_n,
			DDR_dm				=> DDR_dm,
			DDR_dq				=> DDR_dq,
			DDR_dqs_n			=> DDR_dqs_n,
			DDR_dqs_p			=> DDR_dqs_p,
			DDR_odt				=> DDR_odt,
			DDR_ras_n			=> DDR_ras_n,
			DDR_reset_n			=> DDR_reset_n,
			DDR_we_n			=> DDR_we_n,
			
			FIXED_IO_ddr_vrn	=> FIXED_IO_ddr_vrn,
			FIXED_IO_ddr_vrp	=> FIXED_IO_ddr_vrp,
			FIXED_IO_mio		=> FIXED_IO_mio,
			FIXED_IO_ps_clk		=> FIXED_IO_ps_clk,
			FIXED_IO_ps_porb	=> FIXED_IO_ps_porb,
			FIXED_IO_ps_srstb	=> FIXED_IO_ps_srstb,
			            
            GPIO_O              => s_gpio_o,
            GPIO_I              => s_gpio_i,
            
            TMDS_data_p         => TMDS_data_p,
            TMDS_data_n         => TMDS_data_n,
            TMDS_clk_p          => TMDS_clk_p,
            TMDS_clk_n          => TMDS_clk_n,      
            
            clk_25mhz           => clk_25mhz,
            
            			
			RESET_N				=> Rst_N,                        
			
            SDIO0_CDN           => s_sdi0_cdn,
            SDIO0_WP            => '1',
            FCLK_CLK0           => clk0,
            
            -- LTC2358 (ADC)
            ADC1_SCLKO           =>J3_13,
            ADC1_SDO(0)         =>J3_5,
            ADC1_SDO(1)         =>J3_6,
            ADC1_SDO(2)         =>J3_7,
            ADC1_SDO(3)         =>J3_8,
            ADC1_SDO(4)         =>J3_9,
            ADC1_SDO(5)         =>J3_10,
            ADC1_SDO(6)         =>J3_11,
            ADC1_SDO(7)         =>J3_12,
            
            ADC1_BUSY           =>J3_14,
            
            ADC1_CS             =>J3_17,
            ADC1_SCLKI           =>J3_18,
            ADC1_CNV            =>J3_16,
            ADC1_SDI            =>J3_15,
            
            -- CSM INTERFACE
            RSA1    =>J4_26,
            RSA2    =>J4_28,
            RSA3    =>J4_29,
            RSA4    =>J4_30,
            RSA5    =>J4_31,
            RSA6    =>J4_32,              
            RSA7    =>J4_34,
            RSA8    =>J4_35,
                       
            COIL1_SEL_SC    => DIO(0),
            COIL1_SEL_1     => DIO(1),
            COIL1_SEL_2     => DIO(2),
            COIL2_SEL_SC    => DIO(3),
            COIL2_SEL_1     => DIO(4),
            COIL2_SEL_2     => DIO(5),
            
            -- LLD INTERFACE
            LOAD_SEL_OUT(0) => DIO(6),
            LOAD_SEL_OUT(1) => DIO(7),
            LOAD_SEL_OUT(2) => DIO(9),
            
            -- THERMAL CONTROL
            FAN_PWM         => DIO(8)

		);

	------------------------------------------------------------------------------------------------
	--	Clock and Reset
	------------------------------------------------------------------------------------------------ 
	   
	--  reset 1ms reset for Ethernet PHY
   	process (Clk)
   	begin
		if rising_edge (Clk) then
   			if (not RstCnt) = 0 then
   				Rst			<= '0';
   			else
   				Rst			<= '1';
   				RstCnt		<= RstCnt + 1;
	   		end if;
   		end if;
   	end process;
    
	------------------------------------------------------------------------------------------------
	-- Blinking LED counter & LED assignment
	------------------------------------------------------------------------------------------------
   
--    process (clk_25mhz)
--    begin
--    	if rising_edge (clk_25mhz) then
--    		if Rst = '1' then
--    			LedCount	<= (others => '0');
--    		else
--    			LedCount <= LedCount + 1;
--    		end if;
--    	end if;
--    end process;
    
    Led_N(0) <= not LedCount(LedCount'HIGH);
    Led_N(1) <= not LedCount(LedCount'HIGH-1); -- 2 times faster
    Led_N(2) <= not GPIO(1);
    Led_N(3) <= not GPIO(0);

    s_sdi0_cdn <= sdi0_cdn;


	------------------------------------------------------------------------------------------------
	-- Unused pins are set to high impedance in the constraints
	------------------------------------------------------------------------------------------------
end architecture structure;

