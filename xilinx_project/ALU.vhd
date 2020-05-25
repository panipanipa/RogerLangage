----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:38:32 04/30/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           operator : in  STD_LOGIC_VECTOR (2 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

begin
	process(A,B,operator)
	variable result : STD_LOGIC_VECTOR (15 downto 0);
	variable intermediaire : STD_LOGIC_VECTOR (7 downto 0);
		begin
			if operator = "001" then
				result := (b"00000000"&A)+(b"00000000"&B) ;
				S <= result(7 downto 0) ;
				C <= result(8) ;
				if A(7) = '1' and B(7) = '1' then
					O <= not result(7) ;
				elsif A(7) = '0' and B(7) = '0' then
					O <= result(7) ;
				end if ;
			elsif operator = "011" then
				result := (b"00000000"&A)-(b"00000000"&B) ;
				S <= result(7 downto 0) ;
				C <= result(8) ;
				if A(7) = '1' and B(7) = '0' then
					O <= not result(7) ;
				elsif A(7) = '0' and B(7) = '1' then
					O <= result(7) ;
				end if ;
			elsif operator = "010" then
				result := A*B ;
				S <= result(7 downto 0) ;
				intermediaire := result(15 downto 8) ;
				if intermediaire > "00000000" then
					O <= '1' ;
				else
					O <= '0' ;
				end if;
			end if;
	end process;

end Behavioral;

