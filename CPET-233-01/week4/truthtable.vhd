LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--*************************************************************************************************
--Please note that VHDL does not allow for multiple architectures in the same file.
--This file will not compile.
--It is meant to provide students with the multiple solutions to the same problem
--************************************************************************************************

-- "/" represents an inversion 
-- The unsimplified SOP equation is : /A/B/C + A/B/C + A/BC
-- The simplified equation is:  /B/C OR A/B

--        /C  |  C
--   _________|_____
--      |     |                                    |&
--/A/B  |  1  |  0               A ----------------|&
--   ___|_____|_____                           ____|&____
--      |     |                                |   |&    |
--/AB   |  0  |  0                       |\    |         |___|OR
--   ___|_____|_____             B ------| o---|             |OR____f4
--      |     |                          |/    |          ___|OR
-- AB   |  0  |  0                             |___|&    |   |OR
--   ___|_____|_____                     |\        |&____|
--      |     |                  C ------| o-------|&
--A/B   |  1  |  1                       |/        |&
--      |     |
--
ENTITY truthtable IS
	PORT(a, b, c : IN STD_LOGIC;
		  f4      : OUT STD_LOGIC);
END truthtable;

--************************************************************************************************
--This architecture uses AOI gate statements

ARCHITECTURE AOI OF truthtable IS
BEGIN
	
f4 <= ((NOT b) AND (NOT c)) OR (a AND (NOT b));
					
END AOI;

--**************************************************************************************************
--This architecture uses a Conditional signal assignment 

ARCHITECTURE cond_signal OF truthtable IS

   SIGNAL inputs :STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one vector

BEGIN

   inputs <= a & b & c;                          --order is important when concatenating
   f4 <= '1' WHEN inputs = "000" OR inputs = "100" OR inputs = "101" ELSE '0';

				   					
END cond_signal;

--****************************************************************************************************
--This architecture uses a selected signal assignment 

ARCHITECTURE sel_signal OF truthtable IS
 
   SIGNAL inputs :STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one vector
	
BEGIN
	
   inputs <= a & b & c;                          --order is important when concatenating
		
   WITH inputs SELECT
		f4 <= '1' WHEN "000" | "100" | "101",
			   '0' WHEN OTHERS;
					
END sel_signal;
--			
--****************************************************************************************************
--This architecture uses a case statement 
--
ARCHITECTURE case_statement OF truthtable IS
 
   SIGNAL inputs :STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one vector
	
BEGIN
	
   inputs <= a & b & c;                          --order is important when concatenating
		
case_proc: PROCESS(inputs) IS 
BEGIN
   CASE inputs IS 
	   WHEN "000" | "100" | "101" => f4 <= '1'; 
		WHEN OTHERS                => f4 <= '0'; 
	END CASE; 
END PROCESS; 
					
END case_statement;

--****************************************************************************************************
--This architecture uses a if statement 

ARCHITECTURE if_statement OF truthtable IS
 
   SIGNAL inputs :STD_LOGIC_VECTOR(2 DOWNTO 0);  --this will group the inputs into one vector
	
BEGIN
	
   inputs <= a & b & c;                          --order is important when concatenating
		
if_proc: PROCESS(inputs) IS 
BEGIN
   IF (inputs = "000") OR (inputs ="100") THEN   -- You can have multiple conditions on the same line
	   f4 <= '1'; 
   ELSIF (inputs = "101") THEN                   -- Or use ELSIF to split them up
	   f4 <= '1'; 
	ELSE
	   f4 <= '0';
	END IF; 
END PROCESS; 
					
END if_statement;
					