
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Basic_RAT_comp is 
end Test_Basic_RAT_comp;

architecture stimulus of Test_Basic_RAT_comp is
    
    component RAT_MCU
        Port ( IN_PORT  : in  STD_LOGIC_VECTOR (7 downto 0);
               RESET    : in  STD_LOGIC;
               CLK      : in  STD_LOGIC;
               INT      : in  STD_LOGIC;
               OUT_PORT : out  STD_LOGIC_VECTOR (7 downto 0);
               PORT_ID  : out  STD_LOGIC_VECTOR (7 downto 0);
               IO_STRB  : out  STD_LOGIC);
    end component;

    signal C_in     : STD_LOGIC;
    signal Selin    : STD_LOGIC_VECTOR (3 downto 0);
    signal Ain      : STD_LOGIC_VECTOR (7 downto 0);
    signal Bin      : STD_LOGIC_VECTOR (7 downto 0);
    signal Resultout: STD_LOGIC_VECTOR (7 downto 0);
    signal Cout     : STD_LOGIC;
    signal Zout     : STD_LOGIC;
    signal CLK      : STD_LOGIC := '0';
    signal done     : STD_LOGIC := '0';
    constant PERIOD : time := 40 ns;

begin
--    ALU: ALU_RAT
--    port map (Ain, Bin, Selin, C_in, Resultout, Cout, Zout);
    
    my_clk:process
    begin
        while(done = '0') loop
            wait for PERIOD/2;
            CLK <= NOT CLK;
        end loop;
        wait;
    end process
    
    process
    begin
        Selin <= x"0";     --ADD
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;

        Selin <= x"1";      --ADDC
        Ain <= x"C8"; 
        Bin <= x"36";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"2";      --SUB
        Ain <= x"C8"; 
        Bin <= x"64";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"3";      --SUBC
        Ain <= x"C8"; 
        Bin <= x"C8";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"4";      --CMP
        Ain <= x"AA"; 
        Bin <= x"FF";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"4";      --CMP
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"5";      --AND
        Ain <= x"AA"; 
        Bin <= x"CC";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"6";      --OR
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;
                        
        Selin <= x"7";      --EXOR
        Ain <= x"AA"; 
        Bin <= x"AA";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"8";      --TEST
        Ain <= x"AA"; 
        Bin <= x"55";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"9";      --LSL
        Ain <= x"01"; 
        Bin <= x"12";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"10";     --LSR
        Ain <= x"81"; 
        Bin <= x"33";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"12";     --ROL
        Ain <= x"01"; 
        Bin <= x"AB";
        C_in <= '1';
        wait for PERIOD;
        
        Selin <= x"12";     --ROR
        Ain <= x"81"; 
        Bin <= x"3C";
        C_in <= '0';
        wait for PERIOD;
        
        Selin <= x"13";     --ASR
        Ain <= x"81"; 
        Bin <= x"81";
        C_in <= '0';
        wait for PERIOD;
                
        Selin <= x"14";     --MOV
        Ain <= x"50"; 
        Bin <= x"30";
        C_in <= '0';
        wait for PERIOD;
       
    end process;
end stimulus;
    


