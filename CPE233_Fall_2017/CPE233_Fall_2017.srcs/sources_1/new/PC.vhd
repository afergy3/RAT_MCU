-------------------------------------------------------------------------------
-- Andrew Bartfeld, Ryan Statz
-- Experiment 3
-- CPE 233
-- 29 September 2017
-- 
-- Program counter to drive the prog_rom
-------------------------------------------------------------------------------

library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_textio.all;
    use IEEE.std_logic_arith.all;
    use IEEE.numeric_bit.all;
    use IEEE.numeric_std.all;
    use IEEE.std_logic_signed.all;
    use IEEE.std_logic_unsigned.all;

entity PC is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PC_INC : in STD_LOGIC;
           PC_LD : in STD_LOGIC;
           D_IN : in STD_LOGIC_VECTOR (9 downto 0);
           PC_COUNT : out STD_LOGIC_VECTOR (9 downto 0) := "0000000000");
end PC;

architecture Behavioral of PC is
   signal  s_cnt : std_logic_vector(9 downto 0) := "0000000000";
    
begin   
   
    process (CLK, RST, s_cnt) 
    
    begin
    
        if (RST = '1') then   
            s_cnt <= "0000000001"; -- async clear 
            --s_cnt <= (others => '0'); -- async clear  THIS IS THE CORRECT ONE AND I JUST BROKE IT FOR FUN
        elsif (rising_edge(CLK)) then
            if (PC_LD = '1') then 
                s_cnt <= D_IN;  -- load
            else 
                if (PC_INC = '1') then  
                    s_cnt <= s_cnt + 1; -- incr
                end if;
            end if;
        end if;
        
    end process;
    
    PC_COUNT <= s_cnt; 
    
end Behavioral; 