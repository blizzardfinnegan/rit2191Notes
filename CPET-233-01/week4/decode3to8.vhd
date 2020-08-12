LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--*************************************************************************************************
--Please note that VHDL does not allow for multiple architectures in the same file.
--This file will not compile.
--It is meant to provide students with the multiple solutions to the same problem
--************************************************************************************************

--The following is an entity and 8 different architectures for a 3 to 8 decoder
--A decoder works as follows:
--one and only one output can be 1
--the output that is 1 is selected by the binary number formed by the select inputs

--The truth table is below 
--------------------------------------------------------------------------------------------------
--  S2 | S1 | S0 || Y7 | Y6 | Y5 | Y4 | Y3 | Y2 | Y1 | Y0 |
-- ----|----|----||----|----|----|----|----|----|----|----| 
--   0 |  0 |  0 ||  0 |  0 |  0 |  0 |  0 |  0 |  0 |  1 |
--   0 |  0 |  0 ||  0 |  0 |  0 |  0 |  0 |  0 |  1 |  0 |  
--   0 |  0 |  0 ||  0 |  0 |  0 |  0 |  0 |  1 |  0 |  0 |   
--   0 |  0 |  0 ||  0 |  0 |  0 |  0 |  1 |  0 |  0 |  0 |   
--   0 |  0 |  0 ||  0 |  0 |  0 |  1 |  0 |  0 |  0 |  0 |   
--   0 |  0 |  0 ||  0 |  0 |  1 |  0 |  0 |  0 |  0 |  0 |   
--   0 |  0 |  0 ||  0 |  1 |  0 |  0 |  0 |  0 |  0 |  0 |   
--   0 |  0 |  0 ||  1 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |   
---------------------------------------------------------- 

--These models of the 3 to 8 decoder have all of the inputs
--and outputs as individual std_logic signals

ENTITY decode3to8 IS
	PORT(s2, s1, s0 : IN STD_LOGIC;
		  y0, y1, y2, y3, y4, y5, y6, y7  : OUT STD_LOGIC);
END decode3to8;

--************************************************************************************************
--this architecture uses a Conditional signal assignment 
--It also uses an internal std_logic_vector signal to assign all of the outputs at once

ARCHITECTURE cond_signal OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
   SIGNAL Y_bus     : STD_LOGIC_VECTOR(7 DOWNTO 0);  --this will create a vector for internal use
	
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating
		
		y0 <= Y_bus(0);             --Y_bus is used internally to hold the output
		y1 <= Y_bus(1);             --values and then assigned to the individual outputs
		y2 <= Y_bus(2);
		y3 <= Y_bus(3);
		y4 <= Y_bus(4);
		y5 <= Y_bus(5);
		y6 <= Y_bus(6);
		y7 <= Y_bus(7);

		Y_bus <= "00000001" WHEN sel_bus = "000" ELSE
			     "00000010" WHEN sel_bus = "001" ELSE
				 "00000100" WHEN sel_bus = "010" ELSE
				 "00001000" WHEN sel_bus = "011" ELSE
				 "00010000" WHEN sel_bus = "100" ELSE
			     "00100000" WHEN sel_bus = "101" ELSE
				 "01000000" WHEN sel_bus = "110" ELSE
				 "10000000";
					
END cond_signal;

--**************************************************************************************************
--this architecture uses a Conditional signal assignment 
--It assigns all outputs individually

 ARCHITECTURE cond_signal OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
	
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating

		Y0 <= '1' WHEN sel_bus = "000" ELSE '0';
		Y1 <= '1' WHEN sel_bus = "001" ELSE '0';
		Y2 <= '1' WHEN sel_bus = "010" ELSE '0';
		Y3 <= '1' WHEN sel_bus = "011" ELSE '0';
		Y4 <= '1' WHEN sel_bus = "100" ELSE '0';
		Y5 <= '1' WHEN sel_bus = "101" ELSE '0';
		Y6 <= '1' WHEN sel_bus = "110" ELSE '0';
		Y7 <= '1' WHEN sel_bus = "111" ELSE '0';
				   					
END cond_signal;

--****************************************************************************************************
--this architecture uses a selected signal assignment 
--It also uses an internal std_logic_vector signal to assign all of the outputs at once

ARCHITECTURE sel_signal OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
   SIGNAL Y_bus     : STD_LOGIC_VECTOR(7 DOWNTO 0);  --this will create a vector for internal use
	
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating
		
		y0 <= Y_bus(0);             --Y_bus is used internally to hold the output
		y1 <= Y_bus(1);             --values and then assigned to the individual outputs
		y2 <= Y_bus(2);
		y3 <= Y_bus(3);
		y4 <= Y_bus(4);
		y5 <= Y_bus(5);
		y6 <= Y_bus(6);
		y7 <= Y_bus(7);

		WITH sel_bus SELECT
		Y_bus <= "00000001" WHEN "000",
			     "00000010" WHEN "001",
				 "00000100" WHEN "010",
				 "00001000" WHEN "011",
				 "00010000" WHEN "100",
			     "00100000" WHEN "101",
				 "01000000" WHEN "110",  
			     "10000000" WHEN OTHERS;
					
END sel_signal;
			
--****************************************************************************************************
--this architecture uses a selected signal assignment 
--It assigns all outputs individually

ARCHITECTURE sel_signal OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
	
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating

		WITH sel_bus SELECT
		   Y0 <= '1' WHEN "000",'0' WHEN OTHERS;
		WITH sel_bus SELECT          --A WITH statement is required for each output
			Y1 <= '1' WHEN "001",'0' WHEN OTHERS;
		WITH sel_bus SELECT	 
			Y2 <= '1' WHEN "010",'0' WHEN OTHERS;
		WITH sel_bus SELECT
			Y3 <= '1' WHEN "011",'0' WHEN OTHERS;
		WITH sel_bus SELECT
			Y4 <= '1' WHEN "100",'0' WHEN OTHERS;
		WITH sel_bus SELECT
			Y5 <= '1' WHEN "101",'0' WHEN OTHERS;
		WITH sel_bus SELECT
			Y6 <= '1' WHEN "110",'0' WHEN OTHERS;  
		WITH sel_bus SELECT
			Y7 <= '1' WHEN "111",'0' WHEN OTHERS;
					
END sel_signal;

--************************************************************************************************
--this architecture uses a Case Statement
--It also uses an internal std_logic_vector signal to assign all of the outputs at once

ARCHITECTURE case_arch OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
   SIGNAL Y_bus     : STD_LOGIC_VECTOR(7 DOWNTO 0);  --this will create a vector for internal use
	
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating
		
		y0 <= Y_bus(0);             --Y_bus is used internally to hold the output
		y1 <= Y_bus(1);             --values and then assigned to the individual outputs
		y2 <= Y_bus(2);
		y3 <= Y_bus(3);
		y4 <= Y_bus(4);
		y5 <= Y_bus(5);
		y6 <= Y_bus(6);
		y7 <= Y_bus(7);
		
   case1:PROCESS(sel_bus)    --sel_bus is read in the process so needs to be in sensitivity list
	   BEGIN
		    CASE sel_bus IS
              WHEN "000" => y_bus <= "00000001";
			  WHEN "001" => y_bus <= "00000010";
			  WHEN "010" => y_bus <= "00000100";
			  WHEN "011" => y_bus <= "00001000";
			  WHEN "100" => y_bus <= "00010000";
			  WHEN "101" => y_bus <= "00100000";
			  WHEN "110" => y_bus <= "01000000";
			  WHEN OTHERS => y_bus <="10000000";
			END CASE;
	  END PROCESS;					
END case_arch;		

--************************************************************************************************
--this architecture uses a Case Statement
--It aassigns each output individually

ARCHITECTURE case_arch OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
  
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating
			
   case2:PROCESS(sel_bus)
	   BEGIN
		    y0 <= '0';  --make all inputs '0' to avoid creating a latch           
		    y1 <= '0';             
		    y2 <= '0';
		    y3 <= '0';
		    y4 <= '0';
		    y5 <= '0';
		    y6 <= '0';
		    y7 <= '0';
		    CASE sel_bus IS
              WHEN "000" => y0 <= '1';  --only the selected output is set to 1
			  WHEN "001" => y1 <= '1';  --all others remain 0 from initial assignment
			  WHEN "010" => y2 <= '1';
			  WHEN "011" => y3 <= '1';
			  WHEN "100" => y4 <= '1';
			  WHEN "101" => y5 <= '1';
			  WHEN "110" => y6 <= '1';
			  WHEN OTHERS => y7 <='1';
			END CASE;
	  END PROCESS;					
END case_arch;				

--************************************************************************************************
--this architecture uses an if/then/else Statement
--It also uses an internal std_logic_vector signal to assign all of the outputs at once

ARCHITECTURE case_if OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
   SIGNAL Y_bus     : STD_LOGIC_VECTOR(7 DOWNTO 0);  --this will create a vector for internal use
	
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating
		
		y0 <= Y_bus(0);             --Y_bus is used internally to hold the output
		y1 <= Y_bus(1);             --values and then assigned to the individual outputs
		y2 <= Y_bus(2);
		y3 <= Y_bus(3);
		y4 <= Y_bus(4);
		y5 <= Y_bus(5);
		y6 <= Y_bus(6);
		y7 <= Y_bus(7);
		
   if1:PROCESS(sel_bus)    --sel_bus is read in the process so needs to be in sensitivity list
	   BEGIN
		    IF sel_bus = "000" THEN      --assign all outputs at once
			     y_bus <= "00000001";
			 ELSIF sel_bus = "001" THEN
			     y_bus <= "00000010";
			 ELSIF sel_bus = "010" THEN 
			     y_bus <= "00000100";
			 ELSIF sel_bus = "011" THEN 
				  y_bus <= "00001000";
			 ELSIF sel_bus = "100" THEN 
				  y_bus <= "00010000";
			 ELSIF sel_bus ="101" THEN 
				  y_bus <= "00100000";
			 ELSIF sel_bus = "110" THEN 
				  y_bus <= "01000000";
			 ELSE  
				  y_bus <="10000000";
			 END IF;
	  END PROCESS;					
END case_if;		

--************************************************************************************************
--this architecture uses a if/then/else Statement
--It aassigns each output individually

ARCHITECTURE if_arch OF decode3to8 IS
 
   SIGNAL sel_bus   : STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one signal
  
BEGIN
	
		sel_bus <= s2 & s1 & s0;    --order is important when concatenating
			
   if2:PROCESS(sel_bus)
	   BEGIN
		    y0 <= '0';  --make all inputs '0' to avoid creating a latch           
		    y1 <= '0';             
		    y2 <= '0';
		    y3 <= '0';
		    y4 <= '0';
		    y5 <= '0';
		    y6 <= '0';
		    y7 <= '0';
		    IF sel_bus = "000" THEN    --assign only the selected output to 1
			     y0 <= '1';             --all others remain 0
			 ELSIF sel_bus = "001" THEN
			     y1 <= '1';
			 ELSIF sel_bus = "010" THEN 
			     y2 <= '1';
			 ELSIF sel_bus = "011" THEN 
				  y3 <= '1';
			 ELSIF sel_bus = "100" THEN 
				  y4 <= '1';
			 ELSIF sel_bus ="101" THEN 
				  y5 <= '1';
			 ELSIF sel_bus = "110" THEN 
				  y6 <= '1';
			 ELSE  
				  y7 <= '1';
			 END IF;
	  END PROCESS;					
END if_arch;				