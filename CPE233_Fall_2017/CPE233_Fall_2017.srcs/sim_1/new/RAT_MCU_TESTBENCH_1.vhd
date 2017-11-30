-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 29.11.2017 23:37:09 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_RAT_wrapper is
end tb_RAT_wrapper;

architecture tb of tb_RAT_wrapper is

    component RAT_wrapper
        port (LEDS     : out std_logic_vector (15 downto 0);
              SEGMENTS : out std_logic_vector (7 downto 0);
              DISP_EN  : out std_logic_vector (3 downto 0);
              SWITCHES : in std_logic_vector (15 downto 0);
              BUTTONS  : in std_logic_vector (3 downto 0);
              RESET    : in std_logic;
              CLK      : in std_logic);
    end component;

    signal LEDS     : std_logic_vector (15 downto 0);
    signal SEGMENTS : std_logic_vector (7 downto 0);
    signal DISP_EN  : std_logic_vector (3 downto 0);
    signal SWITCHES : std_logic_vector (15 downto 0);
    signal BUTTONS  : std_logic_vector (3 downto 0);
    signal RESET    : std_logic;
    signal CLK      : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RAT_wrapper
    port map (LEDS     => LEDS,
              SEGMENTS => SEGMENTS,
              DISP_EN  => DISP_EN,
              SWITCHES => SWITCHES,
              BUTTONS  => BUTTONS,
              RESET    => RESET,
              CLK      => CLK);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2;

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SWITCHES <= (others => '0');
        BUTTONS <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait for 600 ns;

        -- EDIT Add stimuli here
        BUTTONS <= "0001";
        wait for 36 ns;
        BUTTONS <= "0000";

        -- Stop the clock and hence terminate the simulation
        
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_RAT_wrapper of tb_RAT_wrapper is
    for tb
    end for;
end cfg_tb_RAT_wrapper;