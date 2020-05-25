----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:50 05/04/2020 
-- Design Name: 
-- Module Name:    data_memory_file - Behavioral 
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

entity data_memory_file is
    Port ( ad : in  STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end data_memory_file;

architecture Behavioral of data_memory_file is

TYPE ram_t IS ARRAY (0 to 255) of STD_LOGIC_VECTOR(7 downto 0) ;
SIGNAL mem_s : ram_t;

begin

	process
		begin
			wait until CLK'event and CLK='0' ;
			if RST = '0' then
				mem_s <= (others => (others => '0')) ;
			else
				if RW = '0' then
					mem_s(to_integer(unsigned(ad))) <= INPUT ;
				else
					OUTPUT <= mem_s(to_integer(unsigned(ad))) ;
				end if ;
			end if ;
	end process ;


end Behavioral;
