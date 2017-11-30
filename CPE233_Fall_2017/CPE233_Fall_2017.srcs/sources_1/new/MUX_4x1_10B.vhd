library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4x1_10B is
    Port ( a : in STD_LOGIC_VECTOR (9 downto 0);
           b : in STD_LOGIC_VECTOR (9 downto 0);
           c : in STD_LOGIC_VECTOR (9 downto 0);
           d : in STD_LOGIC_VECTOR (9 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           res : out STD_LOGIC_VECTOR (9 downto 0));
end MUX_4x1_10B;

architecture Behavioral of MUX_4x1_10B is

begin
    select1: process (a,b,c,d, sel)
    begin
        case sel is
            when "00" =>
                res <= a;
            when "01" => 
                res <= b;
            when "10" =>
                res <= c;
            when "11" =>
                res <= d;
            when others =>
                res <= a;
        end case;
    end process;
    
end Behavioral;