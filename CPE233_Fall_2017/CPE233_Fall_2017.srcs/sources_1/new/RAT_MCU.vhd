----------------------------------------------------------------------------------
-- Company: Ratner Engineering
-- Engineer: James Ratner
-- 
-- Create Date:    20:59:29 02/04/2013 
-- Design Name: 
-- Module Name:    RAT_MCU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Starter MCU file for RAT MCU. 
--
-- Dependencies: 
--
-- Revision: 3.00
-- Revision: 4.00 (08-24-2016): removed support for multibus
-- Revision: 4.01 (11-01-2016): removed PC_TRI reference
-- Revision: 4.02 (11-15-2016): added SCR_DATA_SEL 
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RAT_MCU is
    Port ( IN_PORT  : in  STD_LOGIC_VECTOR (7 downto 0);
           RESET    : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
           INT      : in  STD_LOGIC;
           OUT_PORT : out  STD_LOGIC_VECTOR (7 downto 0);
           PORT_ID  : out  STD_LOGIC_VECTOR (7 downto 0);
           IO_STRB  : out  STD_LOGIC);
end RAT_MCU;



architecture Behavioral of RAT_MCU is

   component my_prog_rom  
      port (     ADDRESS : in std_logic_vector(9 downto 0); 
             INSTRUCTION : out std_logic_vector(17 downto 0); 
                     CLK : in std_logic);  
   end component;

   component ALU
       Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
              B : in  STD_LOGIC_VECTOR (7 downto 0);
              Cin : in  STD_LOGIC;
              SEL : in  STD_LOGIC_VECTOR(3 downto 0);
              C : out  STD_LOGIC;
              Z : out  STD_LOGIC;
              RESULT : out  STD_LOGIC_VECTOR (7 downto 0));
   end component;

   component CONTROL_UNIT 
       Port ( CLK           : in   STD_LOGIC;
              C             : in   STD_LOGIC;
              Z             : in   STD_LOGIC;
              INT           : in   STD_LOGIC;
              RESET         : in   STD_LOGIC; 
              OPCODE_HI_5   : in   STD_LOGIC_VECTOR (4 downto 0);
              OPCODE_LO_2   : in   STD_LOGIC_VECTOR (1 downto 0);
              
              PC_LD         : out  STD_LOGIC;
              PC_INC        : out  STD_LOGIC;
              PC_MUX_SEL    : out  STD_LOGIC_VECTOR (1 downto 0);		  

              SP_LD         : out  STD_LOGIC;
              SP_INCR       : out  STD_LOGIC;
              SP_DECR       : out  STD_LOGIC;
 
              RF_WR         : out  STD_LOGIC;
              RF_WR_SEL     : out  STD_LOGIC_VECTOR (1 downto 0);

              ALU_OPY_SEL   : out  STD_LOGIC;
              ALU_SEL       : out  STD_LOGIC_VECTOR (3 downto 0);

              SCR_WR        : out  STD_LOGIC;
              SCR_ADDR_SEL  : out  STD_LOGIC_VECTOR (1 downto 0);
			  SCR_DATA_SEL  : out  STD_LOGIC; 

              FLG_C_LD      : out  STD_LOGIC;
              FLG_C_SET     : out  STD_LOGIC;
              FLG_C_CLR     : out  STD_LOGIC;
              FLG_SHAD_LD   : out  STD_LOGIC;
              FLG_LD_SEL    : out  STD_LOGIC;
              FLG_Z_LD      : out  STD_LOGIC;
              
              I_SET    : out  STD_LOGIC;
              I_CLR    : out  STD_LOGIC;

              RST           : out  STD_LOGIC;
              IO_STRB       : out  STD_LOGIC);
   end component;

   component RegisterFile 
       Port ( D_IN   : in     STD_LOGIC_VECTOR (7 downto 0);
              DX_OUT : out    STD_LOGIC_VECTOR (7 downto 0);
              DY_OUT : out    STD_LOGIC_VECTOR (7 downto 0);
              ADRX   : in     STD_LOGIC_VECTOR (4 downto 0);
              ADRY   : in     STD_LOGIC_VECTOR (4 downto 0);
              WE     : in     STD_LOGIC;
              CLK    : in     STD_LOGIC);
   end component;

   component and2
       Port ( a : in STD_LOGIC;
                b : in STD_LOGIC;
                o : out STD_LOGIC);
   end component;

   component PC 
      Port ( RST,CLK,PC_LD,PC_INC : in std_logic; 
             D_IN : in std_logic_vector (9 downto 0);
             PC_COUNT   : out std_logic_vector (9 downto 0)); 
   end component; 
   
   component FlagReg
      Port ( D    : in  STD_LOGIC; --flag input
             LD   : in  STD_LOGIC; --load Q with the D value
             SET  : in  STD_LOGIC; --set the flag to '1'
             CLR  : in  STD_LOGIC; --clear the flag to '0'
             CLK  : in  STD_LOGIC; --system clock
             Q    : out  STD_LOGIC); --flag output
   end component;
   
   component MUX_2x1
       Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
              b : in STD_LOGIC_VECTOR (7 downto 0);
              sel : in STD_LOGIC;
              res : out STD_LOGIC_VECTOR (7 downto 0));
   end component;
   
   component MUX_2x1_10B
          Port ( a : in STD_LOGIC_VECTOR (9 downto 0);
                 b : in STD_LOGIC_VECTOR (9 downto 0);
                 sel : in STD_LOGIC;
                 res : out STD_LOGIC_VECTOR (9 downto 0));
   end component;
   
   component MUX_4x1
       Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
              b : in STD_LOGIC_VECTOR (7 downto 0);
              c : in STD_LOGIC_VECTOR (7 downto 0);
              d : in STD_LOGIC_VECTOR (7 downto 0);
              sel : in STD_LOGIC_VECTOR (1 downto 0);
              res : out STD_LOGIC_VECTOR (7 downto 0));
   end component;
   
   component MUX_4x1_10B
       Port ( a : in STD_LOGIC_VECTOR (9 downto 0);
              b : in STD_LOGIC_VECTOR (9 downto 0);
              c : in STD_LOGIC_VECTOR (9 downto 0);
              d : in STD_LOGIC_VECTOR (9 downto 0);
              sel : in STD_LOGIC_VECTOR (1 downto 0);
              res : out STD_LOGIC_VECTOR (9 downto 0));
      end component;

   component Stack_Pointer
       port ( RST : in std_logic;
             CLK : in std_logic;
             LD : in std_logic;
             INCR : in std_logic; 
             DECR: in std_logic; 
             DATA : in std_logic_vector (7 downto 0); 
             POINT_OUT : out std_logic_vector (7 downto 0)); 
   end component;
   
   component Scratch_Ram
       Port ( DATA_IN  : in  STD_LOGIC_VECTOR (9 downto 0); 
              ADDR     : in  STD_LOGIC_VECTOR (7 downto 0);
              WE       : in  STD_LOGIC; 
              CLK      : in  STD_LOGIC;
              DATA_OUT : out STD_LOGIC_VECTOR (9 downto 0));
   end component;   
   
   -- intermediate signals ----------------------------------
   signal s_pc_ld : std_logic := '0'; 
   signal s_pc_inc : std_logic := '0'; 
   signal s_rst : std_logic := '0'; 
   signal s_pc_mux_sel : std_logic_vector(1 downto 0) := "00"; 
   signal s_pc_count : std_logic_vector(9 downto 0) := (others => '0');   
   signal s_inst_reg : std_logic_vector(17 downto 0) := (others => '0'); 
   signal S_ALU_OPY_SEL : std_logic;
   signal S_ALU_SEL : std_logic_vector (3 downto 0);
   signal S_ALU_MUX : std_logic_vector (7 downto 0);
   signal S_ALU_RESULT : std_logic_vector (7 downto 0);
   signal S_I_SET : std_logic;
   signal S_I_CLR : std_logic;
   signal S_RF_WR : std_logic;
   signal S_RF_DX_OUT : std_logic_vector (7 downto 0);
   signal S_RF_DY_OUT : std_logic_vector (7 downto 0);
   signal S_RF_MUX_OUT : std_logic_vector (7 downto 0);
   signal S_RF_WE_SEL : std_logic_vector (1 downto 0);
   signal S_SP_INCR : std_logic;
   signal S_SP_LD : std_logic;
   signal S_SP_DECR : std_logic;
   signal S_SP_DATA_OUT : std_logic_vector(7 downto 0);
   signal S_SP_DATA_OUT_MINUS_1 : std_logic_vector(7 downto 0);
   signal S_FLG_C_SET : std_logic;
   signal S_FLG_C_CLR : std_logic;
   signal S_FLG_C_LD : std_logic;
   signal S_FLG_Z_LD : std_logic;
   signal S_FLG_LD_SEL : std_logic;
   signal S_FLG_SHAD_LD : std_logic;
   signal S_C_FLAG : std_logic;
   signal S_Z_FLAG : std_logic;
   signal S_SCR_WR : std_logic;
   signal S_SCR_ADDR_SEL : std_logic_vector (1 downto 0);
   signal S_SCR_DATA_SEL : std_logic;
   signal S_SCR_ADDR_IN : std_logic_vector (7 downto 0);
   signal S_C : std_logic;
   signal S_Z : std_logic;
   signal S_SCR_DATA_OUT : std_logic_vector(9 downto 0);
   signal S_SCR_DATA_IN : std_logic_vector(9 downto 0);
   signal S_SCR_DATA_MUX_A : std_logic_vector(9 downto 0);
   signal S_C_SHAD_FLAG : std_logic;
   signal S_Z_SHAD_FLAG : std_logic;
   signal S_INT_FLAG : std_logic;
   signal S_CU_INT_IN : std_logic;
   signal S_PD_DIN : std_logic_vector(9 downto 0);

   
   -- helpful aliases ------------------------------------------------------------------
   alias s_ir_immed_bits : std_logic_vector(9 downto 0) is s_inst_reg(12 downto 3); 
   
   

begin

   prog_rom: my_prog_rom  
   port map(     ADDRESS => s_pc_count, 
             INSTRUCTION => s_inst_reg, 
                     CLK => CLK); 

   my_alu: ALU
   port map ( A => S_RF_DX_OUT,       
              B => S_ALU_MUX,       
              Cin => S_C_FLAG,     
              SEL => S_ALU_SEL,     
              C => S_C,       
              Z => S_Z,       
              RESULT => S_ALU_RESULT); 


   my_cu: CONTROL_UNIT 
   port map ( CLK           => CLK, 
              C             => S_C_FLAG, 
              Z             => S_Z_FLAG, 
              INT           => INT, 
              RESET         => RESET, 
              OPCODE_HI_5   => S_INST_REG(17 downto 13), 
              OPCODE_LO_2   => S_INST_REG(1 downto 0), 
              
              PC_LD         => s_pc_ld, 
              PC_INC        => s_pc_inc,  
              PC_MUX_SEL    => s_pc_mux_sel, 

              SP_LD         => S_SP_LD, 
              SP_INCR       => S_SP_INCR, 
              SP_DECR       => S_SP_DECR, 

              RF_WR         => S_RF_WR, 
              RF_WR_SEL     => S_RF_WE_SEL, 

              ALU_OPY_SEL   => S_ALU_OPY_SEL, 
              ALU_SEL       => S_ALU_SEL,
			  
              SCR_WR        => S_SCR_WR, 
              SCR_ADDR_SEL  => S_SCR_ADDR_SEL,              
			  SCR_DATA_SEL  => S_SCR_DATA_SEL,
			  
              FLG_C_LD      => S_FLG_C_LD, 
              FLG_C_SET     => S_FLG_C_SET, 
              FLG_C_CLR     => S_FLG_C_CLR, 
              FLG_SHAD_LD   => S_FLG_SHAD_LD, 
              FLG_LD_SEL    => S_FLG_LD_SEL, 
              FLG_Z_LD      => S_FLG_Z_LD, 
              I_SET         => S_I_SET, 
              I_CLR         => S_I_CLR,  

              RST           => S_RST,
              IO_STRB       => IO_STRB);
              
   S_SCR_DATA_MUX_A <= "00" & S_RF_DX_OUT;
   S_SP_DATA_OUT_MINUS_1 <= S_SP_DATA_OUT - 1;

   my_regfile: RegisterFile 
   port map ( D_IN   => S_RF_MUX_OUT,   
              DX_OUT => S_RF_DX_OUT,   
              DY_OUT => S_RF_DY_OUT,   
              ADRX   => S_INST_REG(12 downto 8),   
              ADRY   => S_INST_REG(7 downto 3),     
              WE     => S_RF_WR,   
              CLK    => CLK); 


   my_PC: PC 
   port map ( RST        => S_RST,
              CLK        => CLK,
              PC_LD      => S_PC_LD,
              PC_INC     => S_PC_INC,
              D_IN       => S_PD_DIN,
              PC_COUNT   => S_PC_COUNT); 
              
              
   my_PC_MUX: Mux_4x1_10B
   port map ( a     => S_INST_REG(12 downto 3),
              b     => S_SCR_DATA_OUT,
              c     => "1111111111",
              d     => "0000000000",
              sel   => S_PC_MUX_SEL,
              res   => S_PD_DIN);  
              
   my_C_FLAG: FlagReg
   port map ( D     => S_C,
              LD    => S_FLG_C_LD,
              SET   => S_FLG_C_SET,
              CLR   => S_FLG_C_CLR,
              CLK   => CLK,
              Q     => S_C_FLAG);
              
   my_Z_FLAG: FlagReg
   port map ( D     => S_Z,
              LD    => S_FLG_Z_LD,
              SET   => '0',
              CLR   => '0',
              CLK   => CLK,
              Q     => S_Z_FLAG);
              
   my_Shad_C_FLAG: FlagReg
   port map ( D     => S_C_FLAG,
              LD    => S_FLG_SHAD_LD,
              SET   => '0',
              CLR   => '0',
              CLK   => CLK,
              Q     => S_C_SHAD_FLAG);
                            
   my_Shad_Z_FLAG: FlagReg
   port map ( D     => S_Z_FLAG,
              LD    => S_FLG_SHAD_LD,
              SET   => '0',
              CLR   => '0',
              CLK   => CLK,
              Q     => S_Z_SHAD_FLAG);
   
   my_Interupt_FLAG: FlagReg
   port map ( D     => '0',
              LD    => '0',
              SET   => S_I_SET,
              CLR   => S_I_CLR,
              CLK   => CLK,
              Q     => S_INT_FLAG);
              
   my_and: and2
   port map ( a     => INT,
              b     => S_INT_FLAG,
              o     => S_CU_INT_IN);

   my_Reg_Mux: Mux_4x1
   port map ( a     => S_ALU_RESULT,
              b     => S_SCR_DATA_OUT(7 downto 0),
              c     => S_SP_DATA_OUT,
              d     => IN_PORT,
              sel   => S_RF_WE_SEL,
              res   => S_RF_MUX_OUT);   
              
   my_ALU_MUX: Mux_2x1
   port map ( a     => S_RF_DY_OUT,
              b     => S_INST_REG(7 downto 0),
              sel   => S_ALU_OPY_SEL,
              res   => S_ALU_MUX);

   my_SCR_DATA_MUX: Mux_2x1_10B
   port map ( a     => S_SCR_DATA_MUX_A,
              b     => S_PC_COUNT,
              sel   => S_SCR_DATA_SEL,
              res   => S_SCR_DATA_IN);
              
   my_SCR_ADDR_MUX: Mux_4x1
              port map ( a     => S_RF_DY_OUT,
                         b     => S_INST_REG(7 downto 0),
                         c     => S_SP_DATA_OUT,
                         d     => S_SP_DATA_OUT_MINUS_1,
                         sel   => S_SCR_ADDR_SEL,
                         res   => S_SCR_ADDR_IN);   
                         
    my_SCR: Scratch_Ram
        port map (DATA_IN    => S_SCR_DATA_IN,
                  ADDR       => S_SCR_ADDR_IN,
                  WE         => S_SCR_WR,
                  CLK        => CLK,
                  DATA_OUT   => S_SCR_DATA_OUT);
                  
    my_SP: Stack_Pointer
        port map ( RST       => RESET,
                   CLK       => CLK,
                   LD        => S_SP_LD,
                   INCR      => S_SP_INCR, 
                   DECR      => S_SP_DECR, 
                   DATA      => S_RF_DX_OUT, 
                   POINT_OUT => S_SP_DATA_OUT);
                  
   PORT_ID  <= S_INST_REG(7 downto 0);
   OUT_PORT <= S_RF_DX_OUT;
   
          

end Behavioral;