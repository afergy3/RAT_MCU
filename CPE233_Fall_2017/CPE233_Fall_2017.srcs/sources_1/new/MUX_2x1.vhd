library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2x1 is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           res : out STD_LOGIC_VECTOR (7 downto 0));
end MUX_2x1;

architecture Behavioral of MUX_2x1 is

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