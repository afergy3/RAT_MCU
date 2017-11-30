----------------------------------------------------------------------------------
-- Company: Ratner Engineering
-- Engineer: James Ratner
-- 
-- Create Date: 09/21/2017 01:08:51 PM
-- Design Name: 
-- Module Name: counter_8b - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-bit binary up/down counter with synchronous
--              load and asynchronous reset. This model makes 
--              a good starting point for any counter you may
--              need; modify as necessary.  
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Test_Stack_Pointer is
   port ( RST : in std_logic;
          CLK : in std_logic;
          LD : in std_logic;
          INCR : in std_logic; 
          DECR: in std_logic; 
          DATA : in std_logic_vector (7 downto 0); 
          POINT_OUT : out std_logic_vector (7 downto 0)); 
end Test_Stack_Pointer; 

architecture my_pointer of Test_Stack_Pointer is 
   signal  t_cnt : std_logic_vector(7 downto 0); 
begin 
         
   process (CLK, RST, LD, INCR, DECR, DATA, t_cnt) 
   begin
      
      if (rising_edge(CLK)) then
         if (RST = '1') then    
               t_cnt <= (others => '0'); -- sync clear
         elsif (LD = '1') then
               t_cnt <= DATA;  -- load
         elsif (INCR = '1') then
               t_cnt <= t_cnt + 1; -- incr
         elsif (DECR = '1') then
               t_cnt <= t_cnt - 1; -- decr
         end if;
     end if;
   end process;

   POINT_OUT <= t_cnt; 

end my_pointer; 
