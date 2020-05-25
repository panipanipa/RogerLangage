----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:45 04/30/2020 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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

entity register_file is
    Port ( adA : in  STD_LOGIC_VECTOR (3 downto 0);
           adB : in  STD_LOGIC_VECTOR (3 downto 0);
           adW : in  STD_LOGIC_VECTOR (3 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end register_file;

architecture Behavioral of register_file is

TYPE ram_t IS ARRAY (0 to 15) of STD_LOGIC_VECTOR(7 downto 0) ;
SIGNAL ram_s : ram_t;
begin

	process
		begin
			wait until CLK'event and CLK='1' ;
			if RST = '0' then
				ram_s <= (others => (others => '0')) ;
			else
				if W = '1' then
					ram_s(to_integer(unsigned(adW))) <= DATA ;
				end if;
			end if ;
	end process;

QA <= DATA when adA=adW and W='1' else ram_s(to_integer(unsigned(adA))) ;
QB <= DATA when adB=adW and W='1' else ram_s(to_integer(unsigned(adB))) ;
	
	
end Behavioral;

