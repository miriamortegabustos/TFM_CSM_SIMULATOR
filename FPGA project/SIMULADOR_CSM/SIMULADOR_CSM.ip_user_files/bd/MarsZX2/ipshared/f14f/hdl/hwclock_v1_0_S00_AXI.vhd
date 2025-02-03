library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hwclock_v1_0_S00_AXI is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 6
	);
	port (
		-- Users to add ports here
        --ref_clk:        in std_logic;
        pps_in:         in std_logic;
        timer_irq:      out std_logic;
        pps_irq:        out std_logic;
        ts:             out std_logic_vector(63 downto 0);
        pps_out:        out std_logic;
        pps_mark:       out std_logic;
        hw_clk_rst:     out std_logic;
        
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
end hwclock_v1_0_S00_AXI;

architecture arch_imp of hwclock_v1_0_S00_AXI is

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
	constant OPT_MEM_ADDR_BITS : integer := 3;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 16
	signal slv_reg0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg1	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg3	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg5	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg7	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg8	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg9	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg10	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg11	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg12	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg13	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg14	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg15	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	signal aw_en	: std_logic;

    signal s_hwclk_latched:   std_logic_vector(63 downto 0);
    signal s_comp:            unsigned(63 downto 0);
    signal s_hwclk:           unsigned(91 downto 0);
    signal s_ppsts:           unsigned(91 downto 0);
    signal s_pps_delta:       std_logic_vector(31 downto 0);
    signal s_refclk_count:    unsigned(31 downto 0);
    signal s_pps_count:       unsigned(31 downto 0);
    
    signal s_latch_hwclk:   std_logic;
    
    alias s_ctrl_reg:       std_logic_vector(31 downto 0) is slv_reg2;
    alias s_timer_enable:   std_logic is s_ctrl_reg(0);
    alias s_comp_enable:    std_logic is s_ctrl_reg(1);
    alias s_timer_irq_ena:  std_logic is s_ctrl_reg(2);
    alias s_auto_inc_ena:   std_logic is s_ctrl_reg(3);
    alias s_pps_irq_ena:    std_logic is s_ctrl_reg(4);
    alias s_pps_in_edge:    std_logic is s_ctrl_reg(5);
    alias s_pps_ext_ena:    std_logic is s_ctrl_reg(6);
    alias s_hw_clk_rst:     std_logic is s_ctrl_reg(31);
    
    alias s_sts_reg_w:      std_logic_vector(31 downto 0) is slv_reg3;
    alias s_clr_timer_irq:  std_logic is s_sts_reg_w(0);
    alias s_clr_pps_irq:    std_logic is s_sts_reg_w(1);
    
    signal s_sts_reg:       std_logic_vector(31 downto 0);
    alias s_timer_irq:      std_logic is s_sts_reg(0);
    alias s_pps_irq:        std_logic is s_sts_reg(1);
    
    alias s_pps_out_ctrl:   std_logic_vector(31 downto 0) is slv_reg7;
    alias s_pps_out_pol:    std_logic is s_pps_out_ctrl(31);
    alias s_pps_out_width:  std_logic_vector(30 downto 0) is s_pps_out_ctrl(30 downto 0);
    
    signal s_pps_ext_mark:  std_logic;
    signal s_pps_int_mark:  std_logic;
    signal s_pps_mark:      std_logic;
    
    signal s_next_pps_hwclock:          unsigned(63 downto 0);
    signal s_next_pps_hwclock_act:      unsigned(63 downto 0);
    signal s_next_pps_hwclock_updated:  std_logic;
    
    signal s_auto_inc:      unsigned(31 downto 0);
    
    alias s_fract_inc:          std_logic_vector(31 downto 0) is slv_reg13;    -- 4.28 format
    signal s_fract_inc_per_sec: unsigned(31 downto 0);
    signal s_fract_inc_updated: std_logic;
    

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
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
	      slv_reg2 <= (others => '0');
	      slv_reg3 <= (others => '0');
	      slv_reg4 <= (others => '0');
	      slv_reg5 <= (others => '0');
	      slv_reg6 <= (others => '0');
	      slv_reg7 <= (others => '0');
	      slv_reg8 <= (others => '0');
	      slv_reg9 <= (others => '0');
	      slv_reg10 <= (others => '0');
	      slv_reg11 <= (others => '0');
	      slv_reg12 <= (others => '0');
	      --slv_reg13 <= (others => '0');
	      s_fract_inc <= x"a0000000";
	      slv_reg14 <= (others => '0');
	      slv_reg15 <= (others => '0');
	      s_latch_hwclk <= '0';
	      s_next_pps_hwclock_updated <= '0';
	      
	      
	    else
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	      s_latch_hwclk <= '0';
	      s_clr_pps_irq <= '0';
	      s_clr_timer_irq <= '0';
	      s_next_pps_hwclock_updated <= '0';
	      s_fract_inc_updated <= '0';
	      s_hw_clk_rst <= '0';
	       if (slv_reg_wren = '1') then
	        case loc_addr is
	          when b"0000" =>
	            s_latch_hwclk <= '1';
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 0
	                slv_reg0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 1
	                slv_reg1(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 2
	                slv_reg2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 3
	                slv_reg3(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0100" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 4
	                slv_reg4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0101" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 5
	                slv_reg5(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0110" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 6
	                slv_reg6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"0111" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 7
	                slv_reg7(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 8
	                slv_reg8(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 9
	                slv_reg9(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 10
	                slv_reg10(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 11
	                slv_reg11(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1100" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 12
	                slv_reg12(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1101" =>
	            s_fract_inc_updated <= '1';
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 13
	                slv_reg13(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1110" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 14
	                slv_reg14(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"1111" =>
	            s_next_pps_hwclock_updated <= '1';
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 15
	                slv_reg15(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when others =>
	            slv_reg0 <= slv_reg0;
	            slv_reg1 <= slv_reg1;
	            slv_reg2 <= slv_reg2;
	            slv_reg3 <= slv_reg3;
	            slv_reg4 <= slv_reg4;
	            slv_reg5 <= slv_reg5;
	            slv_reg6 <= slv_reg6;
	            slv_reg7 <= slv_reg7;
	            slv_reg8 <= slv_reg8;
	            slv_reg9 <= slv_reg9;
	            slv_reg10 <= slv_reg10;
	            slv_reg11 <= slv_reg11;
	            slv_reg12 <= slv_reg12;
	            slv_reg13 <= slv_reg13;
	            slv_reg14 <= slv_reg14;
	            slv_reg15 <= slv_reg15;
	        end case;
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

	process (slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11, slv_reg12, slv_reg13, slv_reg14, slv_reg15, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	begin
	    -- Address decoding for reading registers
	    loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	    case loc_addr is
	      when b"0000" =>
	        reg_data_out <= s_hwclk_latched(31 downto 0); --slv_reg0;
	      when b"0001" =>
	        reg_data_out <= s_hwclk_latched(63 downto 32); --slv_reg1;
	      when b"0010" =>
	        reg_data_out <= slv_reg2;  -- control reg
	      when b"0011" =>
	        reg_data_out <= s_sts_reg; -- slv_reg3;  
	      when b"0100" =>
	        reg_data_out <= std_logic_vector(s_comp(31 downto 0)); --slv_reg4;
	      when b"0101" =>
	        reg_data_out <= std_logic_vector(s_comp(63 downto 32)); --slv_reg5;
	      when b"0110" =>
	        reg_data_out <= slv_reg6;  -- auto_inc
	      when b"0111" =>
	        reg_data_out <= slv_reg7;  -- pps out width
	      when b"1000" =>
	        reg_data_out <= std_logic_vector(s_refclk_count); --slv_reg8;
	      when b"1001" =>
	        reg_data_out <= std_logic_vector(s_pps_count); --slv_reg9;
	      when b"1010" =>
	        reg_data_out <= std_logic_vector(s_ppsts(59 downto 28)); --slv_reg10;
	      when b"1011" =>
	        reg_data_out <= std_logic_vector(s_ppsts(91 downto 60)); --slv_reg11;
	      when b"1100" =>
	        reg_data_out <= s_pps_delta;
	      when b"1101" =>
	        reg_data_out <= s_fract_inc;
	      when b"1110" =>
	        reg_data_out <= std_logic_vector(s_next_pps_hwclock_act(31 downto 0));
	      when b"1111" =>
	        reg_data_out <= std_logic_vector(s_next_pps_hwclock_act(63 downto 32));
	      when others =>
	        reg_data_out  <= (others => '0');
	    end case;
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

    process(s_axi_aclk)
        begin
            if rising_edge(s_axi_aclk) then
                if S_AXI_ARESETN = '0' or s_hw_clk_rst = '1' then
                    s_hwclk <= (others => '0');
                else
                    s_hwclk <= s_hwclk + unsigned(s_fract_inc);
                end if;
            end if;
       end process;

    process(s_axi_aclk)
        variable dly: std_logic_vector(4 downto 0);
        variable clk_count: unsigned(31 downto 0);
        variable pps_delta: unsigned(91 downto 0);
        begin
            if rising_edge(s_axi_aclk) then
                if S_AXI_ARESETN = '0' then
                    dly:= (others => '0');                    
                else
                    s_pps_ext_mark <= '0';
                    if dly(4 downto 3) = "01" then
                        s_pps_ext_mark <= '1';
                    end if; 
                    if s_pps_in_edge = '0' then 
                        dly:= dly(3 downto 0) & pps_in;
                    else
                        dly:= dly(3 downto 0) & not pps_in;
                    end if;
                end if;
            end if;
       end process;
       
    process(s_axi_aclk)
        variable delta: unsigned(63 downto 0);
        begin
            if rising_edge(s_axi_aclk) then
                if s_axi_aresetn = '0' then
                    s_fract_inc_per_sec <= x"3b9aca00";
                else
                    if s_fract_inc_updated = '1' then
                        delta:= to_unsigned((to_integer(unsigned(s_fract_inc)) * 100000000), 64);
                        s_fract_inc_per_sec <= delta(63 downto 32);
                    end if;
                end if;
            end if;
        end process;                                            
       
    process(s_axi_aclk)
        variable hw_clk_next_pps: unsigned(63 downto 0);
        variable delta: unsigned(63 downto 0);
        begin
            if rising_edge(s_axi_aclk) then
                if s_axi_aresetn = '0' then
                    hw_clk_next_pps:= (others => '0');                        
                else
                    if s_next_pps_hwclock_updated = '1' then
                        hw_clk_next_pps:= s_next_pps_hwclock;
                        s_next_pps_hwclock_act <= s_next_pps_hwclock;
                    end if;                        
                    if s_hwclk(91 downto 28) >= hw_clk_next_pps then
                        s_pps_int_mark <= '1';
                        hw_clk_next_pps:= s_hwclk(91 downto 28) + 1000000000; --s_fract_inc_per_sec;
                        s_next_pps_hwclock_act <= hw_clk_next_pps; 
                    else
                        s_pps_int_mark <= '0';
                    end if;
                end if;
            end if;
        end process;          
       
    process(s_axi_aclk)
        variable clk_count: unsigned(31 downto 0);
        variable pps_delta: unsigned(91 downto 0);
        begin
            if rising_edge(s_axi_aclk) then
                if S_AXI_ARESETN = '0' then
                    s_refclk_count <= (others => '0');                                      
                    clk_count:= (others => '0');
                    s_pps_irq <= '0';
                    s_pps_count <= (others => '0');
                else
                    clk_count:= clk_count + 1;
                    if s_clr_pps_irq = '1' then
                        s_pps_irq <= '0';
                    end if;
                    if s_pps_mark = '1' then
                        s_pps_count <= s_pps_count+1;
                        pps_delta:= s_hwclk - s_ppsts;
                        s_pps_delta <= std_logic_vector(pps_delta(59 downto 28));
                        s_ppsts <= s_hwclk;
                        s_pps_irq <= '1';
                        s_refclk_count <= clk_count;
                        clk_count:= (others => '0');
                    end if; 
                end if;
            end if;
       end process;                                                                       

    process (s_axi_aclk) is
        begin
            if rising_edge(s_axi_aclk) then
                if s_latch_hwclk = '1' then
                    s_hwclk_latched <= std_logic_vector(s_hwclk(91 downto 28));
                end if;
            end if;
        end process;                                                                    
       
    process(s_axi_aclk) is
        begin
            if rising_edge(s_axi_aclk) then
                if s_axi_aresetn = '0' then
                    s_timer_irq <= '0';
                else
                    if s_clr_timer_irq = '1' then
                        s_timer_irq <= '0';
                    end if;
                    if s_comp_enable = '1' then
                        if unsigned(s_hwclk(91 downto 28)) >= s_comp then
                            s_timer_irq <= '1';
                            if s_auto_inc_ena = '1' then
                                s_comp <= s_comp + s_auto_inc;
                            end if;
                        end if;
                    end if;
                end if;
            end if;                
        end process;    
        
    process(s_axi_aclk) is
        variable count: unsigned(30 downto 0);
        begin
            if rising_edge(s_axi_aclk) then
                if s_axi_aresetn = '0' then
                    pps_out <= s_pps_out_pol;
                    count:= (others => '0');
                else
                    if s_pps_mark = '1' then
                        pps_out <= not s_pps_out_pol;
                        count:= unsigned(s_pps_out_width);
                    elsif count > 0 then
                        pps_out <= not s_pps_out_pol;
                        count:= count - 1;
                    else
                        pps_out <= s_pps_out_pol;
                    end if;                                        
                end if;
            end if;                        
        end process;                
                    
s_next_pps_hwclock <= unsigned(slv_reg15 & slv_reg14);        
            
s_comp <= unsigned(slv_reg5) & unsigned(slv_reg4);

ts <= std_logic_vector(s_hwclk(91 downto 28));

pps_irq <= s_pps_irq when s_pps_irq_ena = '1' else '0';
timer_irq <= s_timer_irq when s_timer_irq_ena = '1' else '0';

hw_clk_rst <= s_hw_clk_rst;

s_pps_mark <= s_pps_ext_mark when s_pps_ext_ena = '1' else s_pps_int_mark;
pps_mark <= s_pps_mark;

	-- User logic ends

end arch_imp;
