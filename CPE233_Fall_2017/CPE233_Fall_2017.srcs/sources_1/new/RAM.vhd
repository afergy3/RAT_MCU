----------------------------------------------------------------------------------
-- Company: RAT Technologies 
-- Engineer: James Ratner
-- 
-- Create Date:    03:44:42 02/17/2015 
-- Design Name: 
-- Module Name:    RAM
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Generic 32x4 RAM with synchronous writes and 
--              asynchronous reads.  
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
    Port ( IN_DATA  : in  STD_LOGIC_VECTOR (3 downto 0);
	       OUT_DATA : out STD_LOGIC_VECTOR (3 downto 0); 
           ADDR     : in  STD_LOGIC_VECTOR (4 downto 0);
           WE       : in  STD_LOGIC; 
           CLK      : in  STD_LOGIC);
end RAM;

architecture gen_ram of ram is
   TYPE memory is array (0 to 31) of std_logic_vector(3 downto 0);
   SIGNAL MY_RAM : memory := (others => (others =>'0') );
begin

   the_ram: process(CLK,WE,IN_DATA,ADDR,MY_RAM)
   begin
       if (WE = '1') then 
          if (rising_edge(CLK)) then 
              MY_RAM(conv_integer(ADDR)) <= IN_DATA;
          end if; 
       end if; 
 
       OUT_DATA <= MY_RAM(conv_integer(ADDR));
 

   end process the_ram; 
   	
end gen_ram;