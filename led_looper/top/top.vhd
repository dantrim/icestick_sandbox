library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library led_looper;
use led_looper.constants.all;

entity top is
  generic (
      PULSE_TIME_MS : natural := led_pulse_time_ms
  );
  port (
        clk : in std_logic;
        rst_button_i: in std_logic; -- user button
        leds_o : out std_logic_vector(3 downto 0) -- the 4 green LEDs on the Lattice iCEStick40
  );
end top; 

architecture rtl of top is

    -- constants
    constant clk_cycles_per_pulse : natural
        := natural((clock_frequency / 1.0e3)) * PULSE_TIME_MS;

    subtype pulse_counter_type is natural range 0 to clk_cycles_per_pulse - 1;
    signal pulse_counter : pulse_counter_type;

    subtype led_index_type is unsigned(1 downto 0);
    signal led_index : led_index_type;

    -- signals
    signal leds : std_logic_vector(leds_o'range);


begin

    -- concurrent assignments
    leds_o <= leds;

    -- simple checks (will assert in simulation runtime and/or during synthesis)
    assert clk_cycles_per_pulse > 0 severity failure;
    assert clk_cycles_per_pulse < natural(clock_frequency) severity failure;

    COUNT_PROC : process(clk)
    begin
        if rising_edge(clk) then
            if rst_button_i = '1' then
                pulse_counter <= 0;
                led_index <= (others => '0');
            else
                -- wrap, or increment
                if pulse_counter = pulse_counter_type'high then
                    pulse_counter <= 0;
                else
                    pulse_counter <= pulse_counter + 1;
                    -- TODO: should move where this happens
                    -- TODO: check more efficient wrap around by using precice/integer number of clock cycles instead of pulse_counter variable
                    led_index <= led_index + 1;
                end if;
            end if;
        end if;
    end process;

    LED_PROC : process(clk)
    begin
        --leds <= (others => '0');
        if rising_edge(clk) then
            if rst_button_i = '1' then
                leds <= (others => '0');
            else 
                if pulse_counter = pulse_counter_type'high then
                    report "foo";
                    leds <= (others => '0');
                    leds(to_integer(led_index)) <= not leds(to_integer(led_index));
                end if;
            end if;
        end if;
    end process;

end architecture;
