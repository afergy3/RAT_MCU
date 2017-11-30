----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrew Bartfeld, Ryan Statz, Meletios Mastrodemos
-- 
-- Create Date: 10/09/2017 09:50:09 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_textio.all;
    use IEEE.std_logic_arith.all;
    use IEEE.std_logic_unsigned.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           SEL : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           RESULT : out STD_LOGIC_VECTOR (7 downto 0);
           C : out STD_LOGIC;
           Z : out STD_LOGIC);
end ALU;

architecture ALU_ARCH of ALU is

begin

    process(A, B, Cin, SEL)
        variable res : std_logic_vector(8 downto 0) := "000000000";

    begin
        
        res := "000000000";
        
        case SEL is
            when "0000" => -- ADD
                res := ('0' & A) + ('0' & B);
            
            when "0001" => -- ADDC
                res := ('0' & A) + ('0' & B) + Cin;
                
            when "0010" => -- SUB
                res := ('1' & A) - ('1' & B);
                
            when "0011" => -- SUBC
                res := ('1' & A) - ('1' & B) - Cin;
                
            when "0100" => -- CMP
                res := ('1' & A) - ('1' & B);
              
            when "0101" => -- AND
                res := ('0' & A) and ('0' & B);
            
            when "0110" => -- OR
                res := ('0' & A) or ('0' & B);
            
            when "0111" => -- EXOR
                res := ('0' & A) xor ('0' & B);
                
            when "1000" => -- TEST
                res := ('0' & A) and ('0' & B);
            
            when "1001" => -- LSL
                res(7 downto 0) := A(6 downto 0) & Cin;
                res(8) := A(7);

            when "1010" => -- LSR
                res(7 downto 0) := Cin & A(7 downto 1);
                res(8) := A(0);
                
            when "1011" => -- ROL
                res(7 downto 0) := A(6 downto 0) & A(7);
                res(8) := A(7);
                
            when "1100" => -- ROR
                res(7 downto 0) := A(0) & A(7 downto 1);
                res(8) := A(0);
                
            when "1101" => -- ASR
                res(7 downto 0) := A(7) & A(7) & A(6 downto 1);
                res(8) := A(0);
                
            when "1110" => -- MOV
                res := ('0' & B);
                
            when others => 
                res := "000000000";
            
        end case;    
            
        if res(7 downto 0) = "00000000" then
            Z <= '1';
        else 
            Z <= '0';
        end if;
        
        C <= res(8);  
        RESULT <= res(7 downto 0); 
                                                
    end process;
          
end ALU_ARCH;