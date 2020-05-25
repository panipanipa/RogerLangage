----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:40:02 05/04/2020 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( CLK : in STD_LOGIC;
			  A : inout  STD_LOGIC_VECTOR (7 downto 0);
           B : inout  STD_LOGIC_VECTOR (7 downto 0);
           C : inout  STD_LOGIC_VECTOR (7 downto 0);
           OP : inout  STD_LOGIC_VECTOR (3 downto 0));
end pipeline;

architecture Behavioral of pipeline is

begin

	LI_DI:process(CLK) begin
		null ;
	end process LI_DI ;
	
	DI_EX:process(CLK) begin
		null ;
	end process DI_EX ;
	
	EX_Mem:process(CLK) begin
		null ;
	end process EX_Mem ;
	
	Mem_RE:process(CLK) begin
		null ;
	end process Mem_RE ;


end Behavioral;

