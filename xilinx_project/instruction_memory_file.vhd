----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:06 05/04/2020 
-- Design Name: 
-- Module Name:    instruction_memory_file - Behavioral 
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

entity instruction_memory_file is
    Port ( ad : in  STD_LOGIC_VECTOR(8 downto 0);
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end instruction_memory_file;

architecture Behavioral of instruction_memory_file is

TYPE rom_t IS ARRAY (0 to 255) of STD_LOGIC_VECTOR(31 downto 0) ;
SIGNAL rom_s : rom_t := (X"06040700", X"06060900", X"06060A00", X"05050400", others => X"00000000");

-- X"06040700", X"05050400", X"02050504", X"08000500", X"07060000",

begin
	process
		begin
			wait until CLK'event and CLK='1' ;
			OUTPUT <= rom_s(to_integer(unsigned(ad))) ;
	end process ;

end Behavioral;

