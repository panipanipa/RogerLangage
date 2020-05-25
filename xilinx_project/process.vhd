----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:56 05/12/2020 
-- Design Name: 
-- Module Name:    process - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
    Port ( CLK : in STD_LOGIC;
			  RST : in STD_LOGIC);
end processor;

architecture Behavioral of processor is

component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           operator : in  STD_LOGIC_VECTOR (2 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC);
end component;

component data_memory_file is
    Port ( ad : in  STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component instruction_memory_file is
    Port ( ad : in  STD_LOGIC_VECTOR (8 downto 0);
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component register_file is
    Port ( adA : in  STD_LOGIC_VECTOR (3 downto 0);
           adB : in  STD_LOGIC_VECTOR (3 downto 0);
           adW : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

SIGNAL LI_DI_OP : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL LI_DI_A : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL LI_DI_B : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL LI_DI_C : STD_LOGIC_VECTOR (7 downto 0) ;

SIGNAL DI_EX_OP : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL DI_EX_A : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL DI_EX_B : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL DI_EX_C : STD_LOGIC_VECTOR (7 downto 0) ;

SIGNAL EX_MEM_OP : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL EX_MEM_A : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL EX_MEM_B : STD_LOGIC_VECTOR (7 downto 0) ;

SIGNAL MEM_RE_OP : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL MEM_RE_A : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL MEM_RE_B : STD_LOGIC_VECTOR (7 downto 0) ;

SIGNAL IP : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
SIGNAL MEM_INSTR : STD_LOGIC_VECTOR (31 downto 0) ;
SIGNAL W : STD_LOGIC ;
SIGNAL QA : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL QB : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL DATA : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL adW : STD_LOGIC_VECTOR (3 downto 0);

SIGNAL CTRL_ALU : STD_LOGIC_VECTOR(2 downto 0) ;
SIGNAL S : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL N : STD_LOGIC ;
SIGNAL O : STD_LOGIC ;
SIGNAL Z : STD_LOGIC ;
SIGNAL C : STD_LOGIC ;

SIGNAL ad : STD_LOGIC_VECTOR (7 downto 0) ;
SIGNAL RW : STD_LOGIC ;
SIGNAL OUTPUT : STD_LOGIC_VECTOR (7 downto 0) ;

begin

ins : instruction_memory_file port map (IP, CLK, MEM_INSTR) ;
reg : register_file port map (LI_DI_B(3 downto 0), LI_DI_C(3 downto 0), MEM_RE_A(3 downto 0), RST, CLK, W, MEM_RE_B, QA, QB) ;
arithmetic : ALU port map (DI_EX_B, DI_EX_C, CTRL_ALU, S, N, O, Z, C) ;
mem : data_memory_file port map (ad, EX_MEM_B, RW, RST, CLK, OUTPUT) ;

  process
	VARIABLE CONFLICT_DURATION : INTEGER := 0 ;
	VARIABLE CONFLICT_CURRENT_PERIOD : INTEGER := 0 ;
	begin
	wait until CLK'event and CLK='1';
		
		if CONFLICT_DURATION = 0 then
			if (MEM_INSTR(31 downto 24) = "00000001" or MEM_INSTR(31 downto 24) = "00000010" or MEM_INSTR(31 downto 24) = "00000011") then
				-- BOTH LI_DI_B AND LI_DI_C ARE READ ACCESS REGISTERS 
				if LI_DI_OP > "00000000" and LI_DI_OP < "00001000" and (LI_DI_A = MEM_INSTR(15 downto 8) or LI_DI_A = MEM_INSTR(7 downto 0)) then
					CONFLICT_DURATION := 3 ;
					CONFLICT_CURRENT_PERIOD := 1 ;
				elsif DI_EX_OP > "00000000" and DI_EX_OP < "00001000" and (DI_EX_A = MEM_INSTR(15 downto 8) or DI_EX_A = MEM_INSTR(7 downto 0)) then
					CONFLICT_DURATION := 2 ;
					CONFLICT_CURRENT_PERIOD := 1 ;
				else
					CONFLICT_CURRENT_PERIOD := 0 ;
				end if ;
			elsif MEM_INSTR(31 downto 24) = "00000101" or MEM_INSTR(31 downto 24) = "00001000" then
				-- ONLY LI_DI_B IS A READ ACCESS REGISTER
				if LI_DI_OP > "00000000" and LI_DI_OP < "00001000" and LI_DI_A = MEM_INSTR(15 downto 8) then
					CONFLICT_DURATION := 3 ;
					CONFLICT_CURRENT_PERIOD := 1 ;
				elsif DI_EX_OP > "00000000" and DI_EX_OP < "00001000" and DI_EX_A = MEM_INSTR(15 downto 8) then
					CONFLICT_DURATION := 2 ;
					CONFLICT_CURRENT_PERIOD := 1 ;
				else
					CONFLICT_CURRENT_PERIOD := 0 ;
				end if ;
			else
				CONFLICT_CURRENT_PERIOD := 0 ;
			end if ;
		else
			CONFLICT_CURRENT_PERIOD := 0 ;
		end if ;
		
		if CONFLICT_CURRENT_PERIOD = 1 or CONFLICT_DURATION = 0 then
			LI_DI_OP <= MEM_INSTR(31 downto 24) ;
			LI_DI_A <= MEM_INSTR(23 downto 16) ;
			LI_DI_B <= MEM_INSTR(15 downto 8) ;
			LI_DI_C <= MEM_INSTR(7 downto 0) ;
		end if ;
			

		if CONFLICT_DURATION > 0 and CONFLICT_CURRENT_PERIOD = 0 then
			DI_EX_OP <= "00000000" ;
			DI_EX_A <= "00000000" ;
			DI_EX_B <= "00000000" ;
			DI_EX_C <= "00000000" ;
		else
			DI_EX_OP <= LI_DI_OP ;
			DI_EX_A <= LI_DI_A ;
			if LI_DI_OP="00000110" or LI_DI_OP="00000000" then
				DI_EX_B <= LI_DI_B  ; --DO NOT SEEK VALUE IN REGISTER IF AFC OR NOP INSTRUCTIONS
			else
				DI_EX_B <= QA;
			end if ;
			DI_EX_C <= QB ;
		end if ;	
		
		if CONFLICT_DURATION > 0 then
			CONFLICT_DURATION := CONFLICT_DURATION-1 ;
		end if ;
		
		if CONFLICT_DURATION = 0 then
			IP <= IP + "000000001" ;
		end if ;
		
		EX_MEM_OP <= DI_EX_OP ;
		EX_MEM_A <= DI_EX_A ;
		if CTRL_ALU > "000" then
			EX_MEM_B <= S ;
		else
			EX_MEM_B <= DI_EX_B ;
		end if ;
		
		ad <= EX_MEM_B ;
		if EX_MEM_OP="00001000" then
			ad <= EX_MEM_A ; --STORE INSTRUCTION
		else
			ad <= EX_MEM_B ;
		end if ;
		MEM_RE_OP <= EX_MEM_OP ;
		MEM_RE_A <= EX_MEM_A ;
		if EX_MEM_OP = "0111" then
			MEM_RE_B <= OUTPUT ; --LOADED VALUE IN CASE OF LOAD INSTRUCTION
		else
			MEM_RE_B <= EX_MEM_B ;
		end if ;
		
		
		adW <= MEM_RE_A(3 downto 0) ;
		DATA <= MEM_RE_B ;
		
		assert IP<"100000000" report "Fin Instruction Memory" severity ERROR ;
	end process ;
	
	CTRL_ALU <= DI_EX_OP(2 downto 0) when DI_EX_OP < "0000100" else "000" ;
	W <= '0' when MEM_RE_OP = "00001000" or MEM_RE_OP = "00000000" else '1' ;
	RW <= '0' when EX_MEM_OP = "00001000" else '1';
	
end Behavioral;

	