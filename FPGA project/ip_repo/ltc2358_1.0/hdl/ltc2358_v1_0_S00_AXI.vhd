-------------------------------
-- Miriam Ortega Bustos
-- Febrero 2025
-- IP CORE(S00_AXI): ADC CONTROL TO DETECT CURRENTS
-------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.ltc2358_pkg.all;

entity ltc2358_v1_0_S00_AXI is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 7
	);
	port (
		-- Users to add ports here
		--INPUTS/OUTPUTS ADC: LTC2358
        ADC_SCLKO      : in  STD_LOGIC;
		ADC_BUSY       : in  STD_LOGIC;
		ADC_SDO        : in STD_LOGIC_VECTOR(7 downto 0); 
		ADC_SDI        : out STD_LOGIC;
		ADC_CNV        : out STD_LOGIC;
		ADC_CS         : out STD_LOGIC;
		ADC_SCLKI      : out  STD_LOGIC;		
				
        valid: out std_logic;                               -- Indicates that the current detected is valid
        CURRENT_COIL1: out std_logic_vector(15 downto 0);   -- Current detected from the first coil of the motor
        CURRENT_COIL2: out std_logic_vector(15 downto 0);   -- Current detected from the second coil of the motor  
        CURRENT_LLD: out std_logic_vector(15 downto 0);     -- Current detected from LLD
				
		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		S_AXI_AWVALID	: in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		S_AXI_AWREADY	: out std_logic;
		-- Write data (issued by master, acceped by Slave) 
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		S_AXI_WVALID	: in std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		S_AXI_WREADY	: out std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		S_AXI_BVALID	: out std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		S_AXI_BREADY	: in std_logic;
		-- Read address (issued by master, acceped by Slave)
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		S_AXI_ARVALID	: in std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		S_AXI_ARREADY	: out std_logic;
		-- Read data (issued by slave)
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		S_AXI_RVALID	: out std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		S_AXI_RREADY	: in std_logic
	);
end ltc2358_v1_0_S00_AXI;

architecture arch_imp of ltc2358_v1_0_S00_AXI is

	-- AXI4LITE signals
	signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_bvalid	: std_logic;
	signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := C_S_AXI_ADDR_WIDTH-3;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 32
	
	constant C_NUM_REGS: integer:= 2**(6-2);
	
--	subtype sv32 is std_logic_vector(31 downto 0);
--	type aregs is array(C_NUM_REGS-1 downto 0) of sv32;
	
--	signal s_regs_w:   aregs;
--	signal s_regs_r:   aregs;
	
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	signal aw_en	: std_logic;
	
	-------------------------------------------------------------------
	---- Declaration and definition of all signals used to this IP Core 
	-------------------------------------------------------------------
	-- Signals related to LTC2358 process
	-- Registers to comunications between FPGA and ARM Cortex-A9
	type t_regs is   array(2**(C_S_AXI_ADDR_WIDTH-2)-1 downto 0) of std_logic_vector(31 downto 0);
	signal s_regr:    t_regs; -- Reading register, ARM Cortex-A9 registers reads from FPGA registers (through AXI Protocol)
	signal s_regw:    t_regs; -- Writing register, ARM Cortex-A9 registers writes in FPGA registers (through AXI Protocol)
	
	subtype sv16 is std_logic_vector(15 downto 0);
	type a8sv16 is array(7 downto 0) of sv16;
	
	signal s_adc_data:         a8sv16; -- Conversion result
	signal s_adc_data_avg:     a8sv16; -- Averaging of the result
	signal s_adc_config_word:   std_logic_vector(31 downto 0); --SOftspan word 
    signal s_adc_trig:  std_logic; -- 1 pulse each 5us
    
    signal s_adc_clk_rx:        std_logic;
    
-- Declaration of the component ltc2358clx	
	component ltc2358clx is
        generic(
        use_scko: boolean:= true
    );
	port (
		clk: 				in std_logic;             
		rst: 			    in std_logic;
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
	end component;
	
	

begin
	-- I/O Connections assignments

	S_AXI_AWREADY	<= axi_awready;
	S_AXI_WREADY	<= axi_wready;
	S_AXI_BRESP	<= axi_bresp;
	S_AXI_BVALID	<= axi_bvalid;
	S_AXI_ARREADY	<= axi_arready;
	S_AXI_RDATA	<= axi_rdata;
	S_AXI_RRESP	<= axi_rresp;
	S_AXI_RVALID	<= axi_rvalid;
	-- Implement axi_awready generation
	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	      aw_en <= '1';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- slave is ready to accept write address when
	        -- there is a valid write address and write data
	        -- on the write address and data bus. This design 
	        -- expects no outstanding transactions. 
	           axi_awready <= '1';
	           aw_en <= '0';
	        elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
	           aw_en <= '1';
	           axi_awready <= '0';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	-- Implement axi_awaddr latching
	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- Write Address latching
	        axi_awaddr <= S_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_wready generation
	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1') then
	          -- slave is ready to accept write data when 
	          -- there is a valid write address and write data
	          -- on the write address and data bus. This design 
	          -- expects no outstanding transactions.           
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	-- Implement memory mapped register select and write logic generation
	-- The write data is accepted and written to memory mapped registers when
	-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	-- select byte enables of slave registers while writing.
	-- These registers are cleared when reset (active low) is applied.
	-- Slave register write enable is asserted when valid address and data are available
	-- and the slave is ready to accept the write address and write data.
	slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

	process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      for i in 0 to 31 loop--for i in 0 to 2**(C_S_AXI_ADDR_WIDTH-2)-1 loop
	           s_regw(i) <= (others => '0');
	      end loop;
	    else
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	      if (slv_reg_wren = '1') then
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 0
	                s_regw(to_integer(unsigned(loc_addr)))(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement write response logic generation
	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp   <= "00"; --need to work more on the responses
	    else
	      if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arready generation
	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_araddr  <= (others => '1');
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_arready <= '1';
	        -- Read Address latching 
	        axi_araddr  <= S_AXI_ARADDR;           
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arvalid generation
	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
	        -- Valid read data is available at the read data bus
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
	        -- Read data is accepted by the master
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;

	-- Implement memory mapped register select and read logic generation
	-- Slave register read enable is asserted when valid address is available
	-- and the slave is ready to accept the read address.
	slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid) ;

	process (s_regr, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
	   variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	   begin
	        -- Address decoding for reading registers
	       loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	       reg_data_out <= s_regr(to_integer(unsigned(loc_addr)));
	end process; 

	-- Output register or memory read data
	process( S_AXI_ACLK ) is
	begin
	  if (rising_edge (S_AXI_ACLK)) then
	    if ( S_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_reg_rden = '1') then
	        -- When there is a valid read address (S_AXI_ARVALID) with 
	        -- acceptance of read address by the slave (axi_arready), 
	        -- output the read dada 
	        -- Read address mux
	          axi_rdata <= reg_data_out;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;


	-- Add user logic here
	
--Definition and port map of the component ltc2358
U1_ltc2358clx: ltc2358clx
    generic map(
        use_scko=>true)
    port map(
		clk=> 			S_AXI_ACLK,             
		rst=>   	    S_AXI_ARESETN,
		trig=>			s_adc_trig,	
		adc_sclk_o=>	ADC_SCLKO,				
		adc_sdo=>		ADC_SDO,
		adc_busy=>		ADC_BUSY,
		adc_config=> 	"010010010010010010010010",  -- +/-5V
		
		adc_cs=>			 ADC_CS,
		adc_sclk_i=>		 ADC_SCLKI,                                       
		adc_cnv=>			 ADC_CNV,                                     
		adc_sdi=>			 ADC_SDI,
		adc_data_avg =>      s_adc_data_avg,  
		adc_data=>		     s_adc_data
		
	);


process(S_AXI_ARESETN, S_AXI_ACLK) is
    variable cnt: integer range 0 to 500 := 500;  --Reduce frecuency clock to 5us
begin
        if (S_AXI_ARESETN = '0') then
            cnt := 499;
            valid <= '0';
            s_adc_trig <= '0';            
        elsif rising_edge(S_AXI_ACLK) then
            if cnt > 0 then
                valid <= '0';
                cnt:= cnt - 1;  --Preescaler of 5us
                s_adc_trig <= '0';
            else
                cnt:=499;               
                s_adc_trig <= '1';  
                valid <= '1';               
              end if;          
        end if;       
end process;

-- Read and write of conversion result registers                 
ltc_mapped: for i in 0 to 3 generate
    s_regr(i) <=  s_adc_data(i*2+1) & s_adc_data(i*2);
    s_regr(i+4) <=  s_adc_data_avg(i*2+1) & s_adc_data_avg(i*2);
end generate;

mirror_regs: for i in 8 to 31 generate -- Converts FPGA reading registers to FPGA writing registers
    s_regr(i) <= s_regw(i);
end generate;

--mirror_regs2: for i in 0 to 4 generate -- Converts FPGA reading registers to FPGA writing registers
--   s_adc_data(i)<= s_regw(i)(15 DOWNTO 0);
--end generate;

----map_s_step_n: 
--    s_adc_data(0)<= s_regw(0)(15 DOWNTO 0);     -- FPGA reads from step_n register of "T_motor_driver_tc_regs", struct of ARM Cortex-A9
----map_s_duty: 
--    s_adc_data(1) <= s_regw(1)(15 DOWNTO 0);     -- FPGA reads from duty register of "T_motor_driver_tc_regs", struct of ARM Cortex-A9
----map_s_period: 
--    s_adc_data(2) <= s_regw(2)(15 DOWNTO 0);   -- FPGA reads from period register of "T_motor_driver_tc_regs", struct of ARM Cortex-A9
----map_s_period: 
--    s_adc_data(3) <= s_regw(3)(15 DOWNTO 0);   -- FPGA reads from period register of "T_motor_driver_tc_regs", struct of ARM Cortex-A9
----map_s_period: 
--    s_adc_data(4) <= s_regw(4)(15 DOWNTO 0);   -- FPGA reads from period register of "T_motor_driver_tc_regs", struct of ARM Cortex-A9

--ADC_CURR_DATA <= s_adc_data(0);
        
CURRENT_COIL1   <= s_adc_data(0);
CURRENT_COIL2   <= s_adc_data(1);
CURRENT_LLD     <= s_adc_data(2);
--THERMISTOR_1    <= s_adc_data(3);
--THERMISTOR_2    <= s_adc_data(4);

	-- User logic ends

end arch_imp;
