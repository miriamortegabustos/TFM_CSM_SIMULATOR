----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2023 04:21:53 PM
-- Design Name: 
-- Module Name: Falling_Det - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Falling_Det is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end Falling_Det;

architecture Behavioral of Falling_Det is

signal r0_input                           : std_logic;
signal r1_input                           : std_logic;

begin

process(clk,reset)
    begin
        if (reset='0') then
            r0_input           <= '0';
            r1_input           <= '0';
        elsif(rising_edge(clk)) then
            r0_input           <= input;
            r1_input           <= r0_input;
    end if;
end process;

output            <= not r0_input and r1_input;


end Behavioral;
