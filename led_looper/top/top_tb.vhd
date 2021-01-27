library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.env.finish;

library led_looper;
use led_looper.constants.all;

library led_looper_sim;
use led_looper_sim.constants.all;
use led_looper_sim.sim_subprograms.all; -- gen_clock, print_test_ok

-- testbenches have no ports
entity top_tb is
end top_tb; 

architecture sim of top_tb is

    -- DUT signals
    signal clk : std_logic := '1'; -- put clock at high, so that we have a full clock cycle before
    signal rst_button : std_logic := '0'; -- active high
    signal leds : std_logic_vector(3 downto 0);
    
begin

    -- generate the clock to drive the DUT
    gen_clock(clk);

    -- instantiate the DUT
    DUT : entity led_looper.top(rtl)
    generic map (
        PULSE_TIME_MS => sim_led_pulse_time_ms
    )
    port map (
        clk => clk,
        rst_button_i => rst_button,
        leds_o => leds
    );

    RESET_PROC : process
    begin
        rst_button <= '1'; -- hold the reset
        wait for 1 ms;
        rst_button <= '0';
        wait;
    end process RESET_PROC;


    RUN_PROC : process
    begin
        wait for 10 ms;
        print_test_ok;
        finish;
    end process;
 
end architecture;