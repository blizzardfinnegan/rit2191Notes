--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2017, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne Christman
--
--      FILE NAME:  hexdisplay_tb.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test an eight bit binary to 
--    seven-segment display driver.  The input is an 8-bit binary number.
--    There are two outputs which go to the 7-segment displays to display the 
--    hexadecimal equivalence of the 8-bit binary number.
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 10/10/17 | JWC  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************

LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;            

ENTITY hexdisplay_tb IS
END ENTITY hexdisplay_tb;

ARCHITECTURE test OF hexdisplay_tb IS

--the component name MUST match the entity name of the VHDL module being tested   
    COMPONENT hexdisplay  
        PORT ( In_num    : 	in   STD_LOGIC_VECTOR(7 downto 0);      --8-bit input
               HEX0,HEX1 : 	out  STD_LOGIC_VECTOR(6 downto 0));     --ssd outputs
    END COMPONENT;
 
    -- testbench signals.  These do not need to be modified
    SIGNAL In_num_tb          : std_logic_vector(7 DOWNTO 0);
    --
    SIGNAL HEX0_tb          : std_logic_vector(6 DOWNTO 0);
    SIGNAL HEX1_tb          : std_logic_vector(6 DOWNTO 0); 
    
BEGIN
--this must match component above
    UUT : hexdisplay PORT MAP (  
        In_num         => In_num_tb,
        
        HEX0           => HEX0_tb,
        HEX1           => HEX1_tb
        );

    ---------------------------------------------------------------------------
    -- NAME: Stimulus
    --
    -- DESCRIPTION:
    --    This process will apply the stimulus to the UUT
    ---------------------------------------------------------------------------
  Stimulus: Process
    BEGIN
            -- create a loop to run through all the combinations of R
          FOR j IN 0 TO 255 LOOP
                    -- Assign the R input value
                    In_num_tb <= STD_LOGIC_VECTOR(to_unsigned(j,8));
                    wait for 10 ns;
           End loop;
                    
        Report LF& "**************************" &LF&
        					 "Simulation Complete" &LF&
        					 "**************************" SEVERITY NOTE;    
        -----------------------------------------------------------------------
        -- This last WAIT statement needs to be here to prevent the PROCESS
        -- sequence from restarting.
        -----------------------------------------------------------------------
        WAIT;
    END PROCESS stimulus;


END ARCHITECTURE test;
