library led_looper;
use led_looper.constants.all; -- clock_frequency, led_pulse_time_ms

package sim_constants is

    constant clock_period : time := 1 sec / clock_frequency;

    -- shorter durations for speeding up the simulation
    constant sim_led_pulse_time_ms : natural := 1;

end package;