-------------------------------
-- Miriam Ortega Bustos
-- Febrero 2025
-- IP CORE (S00_AXI): CSM INTERFACE: Motor functionalities
-------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity csm_sim_v1_0_S00_AXI is
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
		valid 		      : in std_logic;                     -- Indiciates that the current received is valid
        CURRENT_COIL1	  : in std_logic_vector(15 downto 0); --Current detected from the first coil of the motor: Represents sin signal
		CURRENT_COIL2     : in std_logic_vector(15 downto 0); --Current detected from the second coil of the motor: Represents cos signal
		
		-- All Solid State Relays
		RSA1              : out std_logic;
        RSA2              : out std_logic;
        RSA3              : out std_logic;
        RSA4              : out std_logic;
        RSA5              : out std_logic;
        RSA6              : out std_logic;                  
        RSA7              : out std_logic;
        RSA8              : out std_logic;
        
        -- All CSM loads to select
        COIL1_SEL_SC      : out std_logic; 
        COIL1_SEL_1       : out std_logic; 
        COIL1_SEL_2       : out std_logic; 
        COIL2_SEL_SC      : out std_logic; 
        COIL2_SEL_1       : out std_logic; 
        COIL2_SEL_2       : out std_logic; 
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
end csm_sim_v1_0_S00_AXI;

architecture arch_imp of csm_sim_v1_0_S00_AXI is

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
	constant OPT_MEM_ADDR_BITS : integer := 4;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 32
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	signal aw_en	: std_logic;
	
	-------------------------------------------------------------------
	---- Declaration and definition of all signals used to this IP Core 
	-------------------------------------------------------------------
	
	type t_regs is   array(2**(C_S_AXI_ADDR_WIDTH-2)-1 downto 0) of std_logic_vector(31 downto 0);
	signal s_regr:    t_regs; -- Reading register, ARM Cortex-A9 registers reads from FPGA registers (through AXI Protocol)
	signal s_regw:    t_regs; -- Writing register, ARM Cortex-A9 registers writes in FPGA registers (through AXI Protocol)
	
	--registers to sw or from sw
	signal s_sim_enable: std_logic_vector(7 downto 0); -- RW RSA outputs follows simulation (1) or forced (0)
	signal s_forced_rsa: std_logic_vector(7 downto 0); -- RW Forced RSA status
--	signal s_state_rsa: std_logic_vector(7 downto 0);  -- R  Current RSA status
    signal s_status: std_logic_vector(7 downto 0);     -- R status to COIL_1_SC & SEL1 &2, COIL_2_SC & SEL1 &2,  (mechanical end 1 or 2)
    
    subtype s32 is signed(31 downto 0);
    subtype s16 is signed(15 downto 0);
    type a8s32 is array(7 downto 0) of s32;

    
    signal s_step_count: s32;                          -- R  Step count
    signal s_prst_val : s32;                           --  W Preset value for step counter
	signal s_adc_th_pos_lo:  s16;                      -- RW Threshold Pos lo
	signal s_adc_th_pos_hi:  s16;                      -- RW Threshold Pos hi
	signal s_adc_th_neg_lo:  s16;                      -- RW Threshold Neg no
	signal s_adc_th_neg_hi:  s16;                      -- RW Threshold Pos hi
	signal s_mech_end1: s32;                             -- RW Low position (30º)
	signal s_mech_end2: s32;                             -- RW Low position (-90º)
    signal s_rsa_min: a8s32;                             -- RW Min level to set rsa(i)
    signal s_rsa_max: a8s32;                              -- RW Max level to set rsa(i)

	signal s_step_count_prst : std_logic;              --    Preset step counter

	signal s_pulse_wr_sin:  std_logic_vector(3 downto 0);
	signal s_pulse_wr_cos:  std_logic_vector(3 downto 0);
	
	signal s_rsa:           std_logic_vector(7 downto 0);
	signal s_limit_low:     std_logic; 
	signal s_limit_high:    std_logic; 
	
	type motor_magnetic_state is (zero, plus_one, plus_two, minus_one, minus_two);
    signal s_sadm_last_state:	motor_magnetic_state;
    	
    	
    -- Declaration of the component: sadm_det_csm	
	component sadm_det_csm is
	port (
		clk							: in std_logic;             
		reset						: in std_logic;		
		din							: in std_logic_vector(15 downto 0);
		din_valid					: in std_logic;
		--ts 							: in std_logic_vector(63 downto 0);
		adc_th_pos_lo				: in s16;
		adc_th_pos_hi				: in s16;
		adc_th_neg_lo				: in s16;
		adc_th_neg_hi				: in s16;
		--pulse_din		 			: out std_logic_vector(63 downto 0);
		pulse_wr					: out std_logic_vector(3 downto 0)
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
	       s_step_count_prst <= '0';
	      for i in 0 to 2**(C_S_AXI_ADDR_WIDTH-2)-1 loop
	       s_regw(i) <= (others => '0');
	      end loop; 
	    else
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	       s_step_count_prst <= '0';
	      if (slv_reg_wren = '1') then
            if to_integer(unsigned(loc_addr)) = 1 then
                s_step_count_prst <= '1';
            end if;
--           if (loc_addr = "00000") then
--               s_start_pyros <= '1';
--           end if;
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 0
	                
	                s_regw(to_integer(unsigned(loc_addr)))(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	      end if;
	      --s_start_pyros <= '0';
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
	
	-- Port mapped of the first current coil of the motor 
	sin_signal: sadm_det_csm
        port map(
        clk							=>S_AXI_ACLK,            
		reset						=>not S_AXI_ARESETN,
		din							=>CURRENT_COIL1,
		din_valid					=>valid,
		--ts 							: in std_logic_vector(63 downto 0);
		adc_th_pos_lo				=>s_adc_th_pos_lo,
		adc_th_pos_hi				=>s_adc_th_pos_hi,
		adc_th_neg_lo				=>s_adc_th_neg_lo,
		adc_th_neg_hi				=>s_adc_th_neg_hi,
		--pulse_din		 			: out std_logic_vector(63 downto 0);
		pulse_wr					=>s_pulse_wr_sin
        );
        
    -- Port mapped of the second current coil of the motor   
    cos_signal: sadm_det_csm
        port map(
        clk							=>S_AXI_ACLK,            
		reset						=>not S_AXI_ARESETN,
		din							=>CURRENT_COIL2,
		din_valid					=>valid,
		--ts 							: in std_logic_vector(63 downto 0);
		adc_th_pos_lo				=>s_adc_th_pos_lo,
		adc_th_pos_hi				=>s_adc_th_pos_hi,
		adc_th_neg_lo				=>s_adc_th_neg_lo,
		adc_th_neg_hi				=>s_adc_th_neg_hi,
		--pulse_din		 			: out std_logic_vector(63 downto 0);
		pulse_wr					=>s_pulse_wr_cos
        );

	-- Add user logic here
    PROCESS (S_AXI_ACLK, S_AXI_ARESETN) 
    
    BEGIN
    
    
	if S_AXI_ARESETN = '0' then
        s_sadm_last_state <= zero;

	elsif S_AXI_ACLK'event and S_AXI_ACLK = '1' then
	
        if s_step_count_prst = '1' then
           s_step_count <= s_prst_val;
        end if;
	
        --if(valid = '1') then
            case s_sadm_last_state is -- FSm for step counter
            
                when zero => 
                    s_sadm_last_state <= plus_one;          -- Initial state
                    
                when plus_one =>                            -- step count + 1
                    if (s_pulse_wr_cos(0) = '1') then
                        s_sadm_last_state <= plus_two;
                        if s_limit_high = '0' then                      
                            s_step_count <= s_step_count + 1;
                        end if;
                    elsif (s_pulse_wr_cos(2) = '1') then
                        s_sadm_last_state <= minus_two;
                        if s_limit_low = '0' then                      
                            s_step_count <= s_step_count - 1;
                        end if;
                    end if;
                 when plus_two =>                               -- step count + 2
                    if (s_pulse_wr_sin(2) = '1') then
                        s_sadm_last_state <= minus_one;
                        if s_limit_high = '0' then                      
                            s_step_count <= s_step_count + 1;
                        end if;
                    elsif (s_pulse_wr_sin(0) = '1') then
                        s_sadm_last_state <= plus_one;
                        if s_limit_low = '0' then                      
                            s_step_count <= s_step_count - 1;
                        end if;
                    end if;    
                 when minus_one =>                              -- step count - 1
                    if (s_pulse_wr_cos(2) = '1') then
                        s_sadm_last_state <= minus_two;
                        if s_limit_high = '0' then                      
                            s_step_count <= s_step_count + 1;
                        end if;
                    elsif (s_pulse_wr_cos(0) = '1') then
                        s_sadm_last_state <= plus_two;
                        if s_limit_low = '0' then                      
                            s_step_count <= s_step_count - 1;
                        end if;
                    end if;  
                  when minus_two =>                             -- step count - 2
                    if (s_pulse_wr_sin(0) = '1') then
                        s_sadm_last_state <= plus_one;
                        if s_limit_high = '0' then                      
                            s_step_count <= s_step_count + 1;
                        end if;
                    elsif (s_pulse_wr_sin(2) = '1') then
                        s_sadm_last_state <= minus_one;
                        if s_limit_low = '0' then                      
                            s_step_count <= s_step_count - 1;
                        end if;
                    end if;    
                when others =>
            end case;
        --end if;   
    end if;

END PROCESS;

PROCESS (S_AXI_ACLK, S_AXI_ARESETN) 

BEGIN

    if S_AXI_ARESETN = '0' then

    elsif S_AXI_ACLK'event and S_AXI_ACLK = '1' then
        if s_step_count <= s_mech_end1 then             -- Set mechanical limits
            s_limit_low <= '1';
        else 
            s_limit_low <= '0';
        end if;
        
        if s_step_count >= s_mech_end2 then              -- Set mechanical limits
            s_limit_high <= '1';
        else 
            s_limit_high <= '0';
        end if;
        
        --Activation or deactivation of all Solid State Relays
        for i in 0 to 7 loop
            if(s_sim_enable(i) = '1') then
                if (s_step_count >= s_rsa_min(i)) and (s_step_count <= s_rsa_max(i)) then
                    s_rsa(i) <= '1';
                else
                    s_rsa(i) <= '0';
                end if;
            else 
                 s_rsa(i) <= s_forced_rsa(i);
            end if;
        end loop;    
    end if;
END PROCESS;

    RSA1 <= s_rsa(0);
    RSA2 <= s_rsa(1);
    RSA3 <= s_rsa(2);
    RSA4 <= s_rsa(3);
    RSA5 <= s_rsa(4);
    RSA6 <= s_rsa(5);
    RSA7 <= s_rsa(6);
    RSA8 <= s_rsa(7);
    
    COIL1_SEL_SC    <= s_status(0);
    COIL1_SEL_1     <= s_status(1);
    COIL1_SEL_2     <= s_status(2);
    COIL2_SEL_SC    <= s_status(3);
    COIL2_SEL_1     <= s_status(4);
    COIL2_SEL_2     <= s_status(5);
    
    s_status(6)     <=  s_limit_low;
    s_status(7)     <=  s_limit_high;
	-- User logic ends
	
	 s_sim_enable              <= s_regw(0)(7 downto 0); 
	 s_forced_rsa              <= s_regw(0)(15 downto 8); 
	 s_regr(0)(15 downto 0)    <= s_regw(0)(15 downto 0);
	 s_status(5 downto 0)      <= s_regw(0)(29 downto 24);

	 
	 s_regr(0)(23 downto 16)   <= s_rsa;
	 s_regr(0)(31 downto 24)   <= s_status;
     ----
     s_regr(1)                 <= std_logic_vector(s_step_count);
	 s_prst_val                <= signed(s_regw(1));
     ----
	 s_adc_th_pos_lo           <= signed(s_regw(2)(15 downto 0));                     
	 s_adc_th_pos_hi           <= signed(s_regw(2)(31 downto 16));
	 s_regr(2)                 <= s_regw(2);
	 ----
	 s_adc_th_neg_lo           <= signed(s_regw(3)(15 downto 0));
	 s_adc_th_neg_hi           <= signed(s_regw(3)(31 downto 16));
	 s_regr(3)                 <= s_regw(3);
	 ----
	 s_mech_end1               <= signed(s_regw(4));
	 s_regr(4)                 <= s_regw(4);
	 ----
	 s_mech_end2                <= signed(s_regw(5));
	 s_regr(5)                  <= s_regw(5);
	 

	 
	 loop_mech: for i in 0 to 7 generate -- Converts FPGA reading registers to FPGA writing registers
         s_rsa_min(i)                <= signed(s_regw(6+i));
         s_regr(6+i)                 <= s_regw(6+i);
         ----
         s_rsa_max(i)                <= signed(s_regw(14+i));
         s_regr(14+i)                <= s_regw(14+i);
     end generate;

     s_regr(22)                  <= CURRENT_COIL2 & CURRENT_COIL1;
	 
	 s_regr(23)(7 downto 0)      <= x"01" when s_sadm_last_state = plus_one else
                                   x"02" when s_sadm_last_state = plus_two else
                                   x"03" when s_sadm_last_state = minus_one else
                                   x"04" when s_sadm_last_state = minus_two else
                                   x"00"; 

end arch_imp;
