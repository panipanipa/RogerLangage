-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 
  
  constant Clock_period : time := 10 ns ;

  -- Component Declaration
          COMPONENT processor
          PORT(
                  CLK : IN std_logic ;
                  RST : IN std_logic       
                  );
          END COMPONENT;

          SIGNAL CLK :  std_logic := '1';
          SIGNAL RST :  std_logic := '1';
          

  BEGIN

  -- Component Instantiation
          test: processor PORT MAP(CLK, RST);

  --clock
	  clock:process begin
	    CLK <= '1' ;
		 wait for Clock_period/2 ;
		 CLK <= '0' ;
		 wait for Clock_period/2 ;
	  end process clock ;
	  
  --  Test Bench Statements

  END;
