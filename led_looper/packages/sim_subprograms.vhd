library ieee;
use ieee.std_logic_1164.all;

use std.textio.all; -- line

library led_looper;
use led_looper.constants.all;

library led_looper_sim;
use led_looper_sim.sim_constants.all;

package sim_subprograms is

    -- generate the clock signal
    procedure gen_clock(signal clk : inout std_logic);

    -- print "test OK"
    procedure print_test_ok;

end package sim_subprograms;

package body sim_subprograms is

    ---------------------------------------------------
    -- generate the sim clock
    ---------------------------------------------------
    procedure gen_clock(signal clk : inout std_logic) is
    begin
        clk <= not clk after clock_period / 2;
    end procedure gen_clock;

    ---------------------------------------------------
    -- print test OK 
    ---------------------------------------------------
    procedure print_test_ok is
        variable str : line;
    begin
        write(str, string'("Test OK"));
        writeline(output, str);
    end procedure print_test_ok;

end package body sim_subprograms;