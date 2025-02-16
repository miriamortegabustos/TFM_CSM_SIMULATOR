-- Author: Miriam Ortega Bustos
-- Year: 2024
-- Description: vhd file for 36V 2ch Stepping Motor Driver (BD68888AEKV)

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE IEEE.std_logic_arith.all;

--LIBRARY xil_defaultlib;
--USE xil_defaultlib.fixed_c.pkg.all;

entity Motor_Driver is
generic(
  delta_t: integer:= 100 --FPGA period: 100MHz ()
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
end Motor_Driver;


architecture behavior of Motor_Driver is

  ------------------------------------------------------------------------
  -- Signals
  ------------------------------------------------------------------------
  
type motor_state_type is (IDLE, FIRST_HALF, SECOND_HALF);
signal s_motor_state: motor_state_type := IDLE;

begin  -- behavior

PROCESS (Clk, Reset) 
variable t1: integer := 0;
variable t2: integer := 0;
variable current_t: integer := 0;
variable step_count: integer := 0;
variable current_step: integer := 0;


BEGIN

	if Reset = '0' then
	   MOTOR_ENA <= '0';
       PHASE1 <= '0';
       PHASE2 <= '0';
       Ich1 <= '1';
       Ich2 <= '1';
	   s_motor_state <= IDLE;
	   current_t := 0;

	elsif Clk'event and Clk = '1' then
        case s_motor_state is
            when IDLE =>
                -- Disable motor
                MOTOR_ENA <= '0';
                PHASE1 <= '0';
                PHASE2 <= '0';
                Ich1 <= '1';
                Ich2 <= '1';
                -- Go to FIRST_HALF when TC received
                if flag_tc = '1' then
                    MOTOR_ENA <= '1';
                    t1 := period * duty / 100;
                    t2 := period;
                    current_t := 0;
                    step_count := step_n -1;    
                    -- Update step according to direction. Must loop.
                    if direction = '1' then
                        current_step := current_step + 1; 
                    else
                        current_step := current_step - 1;
                    end if;
                    if current_step = -1 then
                        current_step := 3;
                    elsif current_step = 4 then
                        current_step := 0;
                    end if;
                    -- Transition to FIRST_HALF
                    s_motor_state <= FIRST_HALF;
                end if;
                
            when FIRST_HALF =>
                -- Update time
                current_t := current_t + delta_t;
                -- Set phases according to step
                case current_step is
                    when 0 =>
                        PHASE1 <= '1';
                        PHASE2 <= '1';
                        Ich1 <= '0';
                        Ich2 <= '1';
                    when 1 =>
                        PHASE1 <= '0';
                        PHASE2 <= '1';
                        Ich1 <= '1';
                        Ich2 <= '0';
                    when 2 =>
                        PHASE1 <= '0';
                        PHASE2 <= '0';
                        Ich1 <= '0';
                        Ich2 <= '1';
                    when 3 =>
                        PHASE1 <= '1';
                        PHASE2 <= '0';
                        Ich1 <= '1';
                        Ich2 <= '0';
                    when others =>
                        PHASE1 <= '0';
                        PHASE2 <= '0';
                        Ich1 <= '1';
                        Ich2 <= '1';
                end case;
                -- Go to second half step after time passes
                if current_t >= t1 then
                    s_motor_state <= SECOND_HALF;
                else 
                end if;
                
            when SECOND_HALF =>
                -- Update time
                current_t := current_t + delta_t;
                -- Set currents to 0
                Ich1 <= '1';
                Ich2 <= '1';
                -- Go to IDLE if all steps executed
                if current_t > t2 and step_count = 0 then
                    MOTOR_ENA <= '0';
                    s_motor_state <= IDLE;
                -- Go to FIRST_HALF if steps still remaining
                elsif  current_t >= t2 then
                    current_t := 0;
                    step_count := step_count - 1;
                    -- Update step according to direction. Must loop.
                    if direction = '1' then
                        current_step := current_step + 1; 
                    else
                        current_step := current_step - 1;
                    end if;
                    if current_step = -1 then
                        current_step := 3;
                    elsif current_step = 4 then
                        current_step := 0;
                    end if;
                    s_motor_state <= FIRST_HALF;
                end if;
        end case;
	end if;

END PROCESS;
 
end behavior;

