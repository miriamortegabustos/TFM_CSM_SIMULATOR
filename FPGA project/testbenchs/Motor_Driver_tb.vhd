----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.11.2023 12:30:36
-- Design Name: 
-- Module Name: PICtop_tb - Behavioral
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

entity Motor_Driver_tb is
--  Port ( );
end Motor_Driver_tb;

architecture Behavioral of Motor_Driver_tb is

component Motor_Driver is
generic(
  delta_t: integer:= 100 --5ns beacuse 200MHz
);

  port (
    reset           : in  std_logic;    --Active low
    clk             : in  std_logic;
    flag_tc         : in  std_logic;
    duty            : in  integer;      --Duty cicle of both PHASE1 and PHASE2 [0-100]
    step_n          : in  integer;      --Number of steps requested
    direction       : in  std_logic;    --Clockwise(1) or counterclockwise(0) direction
    period          : in  integer;       --Period of all steps of the system
    PHASE1          : out  std_logic;    --Phase of channel 1
    PHASE2          : out  std_logic;    --Phase of channel 2
    MOTOR_ENA       : out  std_logic;    --Power Save Pin, 0: ch1 & ch2 outputs in stand-by, 1: Active
    Ich1            : out  std_logic;    --IO1 and I11. 0: ch1 output current level 100%  1: ch1 output current level 0%
    Ich2            : out  std_logic    --IO2 and I12. 0: ch2 output current level 100%  1: ch2 output current level 0%
);
end component;
      
    signal clk             : std_logic;
    signal reset           : std_logic:='0';
    signal flag_tc         : std_logic;
    signal duty            : integer;      --Duty cicle of both PHASE1 and PHASE2 [0-100]
    signal step_n          : integer;      --Number of steps requested
    signal direction       : std_logic;    --Clockwise(1) or counterclockwise(0) direction
    signal period          : integer;       --Period of all steps of the system
    signal PHASE1          : std_logic;    --Phase of channel 1
    signal PHASE2          : std_logic;    --Phase of channel 2
    signal MOTOR_ENA       : std_logic;    --Power Save Pin, 0: ch1 & ch2 outputs in stand-by, 1: Active
    signal Ich1            : std_logic;    --IO1 and I11. 0: ch1 output current level 100%  1: ch1 output current level 0%
    signal Ich2            : std_logic;    --IO2 and I12. 0: ch2 output current level 100%  1: ch2 output current level 0%
    
    constant Tclk: time := 100 ns;  -- Clock Period 
        
begin

Motor_Driverr: Motor_Driver 
  generic map(
  delta_t => 100 --5ns beacuse 200MHz 
)
port map(
    Reset       => Reset,
    Clk         => Clk,
    flag_tc     => flag_tc,
    duty        => duty,
    step_n      => step_n,
    direction   => direction,
    period      => period,
    PHASE1      => PHASE1,
    PHASE2      => PHASE2,
    MOTOR_ENA   => MOTOR_ENA,    --Power Save Pin, 0: ch1 & ch2 outputs in stand-by, 1: Active
    Ich1        => Ich1,    --IO1 and I11. 0: ch1 output current level 100%  1: ch1 output current level 0%
    Ich2        => Ich2    --IO2 and I12. 0: ch2 output current level 100%  1: ch2 output current level 0%
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
    flag_tc         <= '0';
    duty            <= 0;
    step_n          <= 0;
    direction       <= '0';
    period          <= 0;
     
    reset <= '0';
    wait for 100 ns;
    reset <= '1';
    wait for 100 ns;
    
    flag_tc <= '1';
    duty    <= 25;
    step_n  <= 6;      --Number of steps of the system
    period  <= 500;      --Period of all phases of the system
    direction       <= '1';
    wait for 200 ns;
    flag_tc  <= '0';
    
    wait for 10*500 ns;
    
    flag_tc <= '1';
    duty    <= 75;
    step_n  <= 6;      --Number of steps of the system
    period  <= 400;      --Period of all phases of the system
    direction       <= '0';
    wait for 200 ns;
    flag_tc  <= '0';
    
    wait for 10*500 ns;
   
    wait for 40000 ns;
  end process; 

end Behavioral;
