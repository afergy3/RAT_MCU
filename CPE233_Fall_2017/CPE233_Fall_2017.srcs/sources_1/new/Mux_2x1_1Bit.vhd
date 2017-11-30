library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2x1_1Bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           sel : in STD_LOGIC;
           res : out STD_LOGIC);
end MUX_2x1_1Bit;

architecture Behavioral of MUX_2x1_1Bit is

begin
    select1: process (a,b, sel)
    begin
        if sel = '0' then
            res <= a;
        else
            res <= b;
        end if;
    end process;
    
end Behavioral;