library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

package ltc2358_pkg is
	
	type ltc2358_array is array(integer range <>) of std_logic_vector(7 downto 0);
	type adc_config_word_type is array(integer range <>) of std_logic_vector(23 downto 0);
	
	subtype sv16 is std_logic_vector(15 downto 0);
	type a8sv16 is array(7 downto 0) of sv16;
	type a24sv16 is array(23 downto 0) of sv16;
	type a18sv16 is array(17 downto 0) of sv16;
	type a4sv16 is array(3 downto 0) of sv16;
	type a64sv16 is array(63 downto 0) of sv16;
		
	subtype sv64 is std_logic_vector(63 downto 0);
	type a64sv64 is array(63 downto 0) of sv64;
	type a24sv64 is array(23 downto 0) of sv64;		
	
	subtype sv8 is std_logic_vector(7 downto 0);
	type a2sv8 is array(2 downto 0) of sv8;
	--type a3_ltc2358_data is array(2 downto 0) of ltc2358_data;
	
	subtype sv12 is std_logic_vector(11 downto 0);
	type a8sv12 is array(7 downto 0) of sv12;
		
   subtype sv24 is std_logic_vector(23 downto 0);
   type a8sv24 is array(7 downto 0) of sv24;
	
	subtype sv32 is std_logic_vector(31 downto 0);
	type a16sv32 is array(15 downto 0) of sv32;
	type a32sv32 is array(31 downto 0) of sv32;
	type a24sv32 is array(23 downto 0) of sv32;
	
	subtype sv72 is std_logic_vector(71 downto 0);
	type a2sv72 is array(1 downto 0) of sv72;
	
	subtype u16 is unsigned(15 downto 0);
	type a64u16 is array(63 downto 0) of u16;
	type a24u16 is array(23 downto 0) of u16;
	type a18u16 is array(17 downto 0) of u16;
	
	subtype u24 is unsigned(23 downto 0);
	type a64u24 is array(63 downto 0) of u24;
	type a24u24 is array(23 downto 0) of u24;
	type a18u24 is array(17 downto 0) of u24;
	type a8u24 is array(7 downto 0) of u24;
	
	subtype u32 is unsigned(31 downto 0);
	type a24u32 is array(23 downto 0) of u32;
	type a18u32 is array(17 downto 0) of u32;
	
	subtype u34 is unsigned(33 downto 0); --For accumulate register
	type a24u34 is array(23 downto 0) of u34;
	
	subtype u64 is unsigned(63 downto 0);
	type a24u64 is array(23 downto 0) of u64;
	
    subtype s8 is signed(7 downto 0);
    type a16s8 is array(15 downto 0) of s8;
	
	subtype s16 is signed(15 downto 0);
    type a16s16 is array(15 downto 0) of s16;
	type a64s16 is array(63 downto 0) of s16;
	type a18s16 is array(17 downto 0) of s16;
	
	subtype s32 is signed(31 downto 0);
    type a16s32 is array(15 downto 0) of s32;
	type a64s32 is array(63 downto 0) of s32;
	
	subtype s24 is signed(23 downto 0);
	type a8s24 is array(7 downto 0) of s24;
	type a24s24 is array(23 downto 0) of s24;
			
	subtype s64 is signed(63 downto 0);
	type a18s64 is array(17 downto 0) of s64;
	
		
end ltc2358_pkg;

package body ltc2358_pkg is

	-- Type Declaration (optional)

	-- Subtype Declaration (optional)

	-- Constant Declaration (optional)

	-- Function Declaration (optional)

	-- Function Body (optional)

	-- Procedure Declaration (optional)

	-- Procedure Body (optional)

end ltc2358_pkg;
