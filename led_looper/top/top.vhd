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

    -- counters for determining LED light timing and switching
    constant c_CNT_1HZ : integer := 750_000;
    signal r_CNT_1HZ : integer range 0 to c_CNT_1HZ := 0;
    signal r_LED_SELECT : unsigned(1 downto 0);

    -- signals
    signal leds : std_logic_vector(leds_o'range) := (others => '0');


begin

    -- concurrent assignments
    leds_o <= leds;

    COUNT_PROC : process(clk)
    begin
        if rising_edge(clk) then
            if rst_button_i = '1' then
                r_CNT_1HZ <= 0;
                leds <= (others => '0');
                r_LED_SELECT <= (others => '0');
            else
                -- wrap, or increment
                if r_CNT_1HZ = c_CNT_1HZ - 1 then
                    leds <= (others => '0');
                    leds(to_integer(r_LED_SELECT)) <= not leds(to_integer(r_LED_SELECT));
                    r_CNT_1HZ <= 0;
                    r_LED_SELECT <= r_LED_SELECT + 1;
                else
                    r_CNT_1HZ <= r_CNT_1HZ + 1;
                end if;
            end if;
        end if;
    end process;
end architecture;
