--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2017, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne Christman
--
--       LAB NAME:  Lab #4
--
--      FILE NAME:  phone_number_displayer_tb.vhd
--
--   DATE CREATED: 9/13/17
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test a phone_number_displayer. It
--    inputs to the number displayer all combinations of x,y,z&w. This test bench does
--    not do any testing - it only applies the stimuls to the UUT. The outputs
--    need to be verified by visual inspection.
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 9/13/17  | JWC  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;           -- need for to_unsigned

ENTITY phone_number_displayer_tb IS     --this is the test bench entity.
END ENTITY phone_number_displayer_tb;   --It has a different name than the module you are testing

ARCHITECTURE test OF phone_number_displayer_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT phone_number_displayer      --the component name must match your lab4 entity name
        PORT (
            x           : IN  std_logic;  --these port names must match your
            y           : IN  std_logic;  --entity port names exactly
            z           : IN  std_logic;
            w           : IN  std_logic;
            ----------------------------  
            output_case    : OUT std_logic_vector(6 downto 0); 
            output_if      : OUT std_logic_vector(6 downto 0)            
            ); 
    END COMPONENT;


    --Inputs
    SIGNAL inputs : std_logic_vector(3 DOWNTO 0);       --this vector will drive the inputs

    --Outputs
    SIGNAL output_case_tb : std_logic_vector(6 downto 0); 
    SIGNAL output_if_tb   : std_logic_vector(6 downto 0);--these names can be anything
    
BEGIN
    -- Instantiate the Unit Under Test (UUT)
	 -- on left of => are the names of your component's ports above
	 -- on the right of => are the signals that they map to
    uut : phone_number_displayer PORT MAP(
        x           => inputs(3),
        y           => inputs(2),
        z           => inputs(1),
        w           => inputs(0),
        
        --
  
        output_case   => output_case_tb,
        output_if     => output_if_tb
        );


    ---------------------------------------------------------------------------
    -- NAME: Stimulus
    --
    -- DESCRIPTION:
    --    This process will apply the  stimulus to the UUT
    ---------------------------------------------------------------------------
    stimulus : PROCESS
    BEGIN
        FOR i IN 0 TO 15 LOOP
            inputs <= std_logic_vector(to_unsigned(i,4));
            WAIT FOR 10 ns;
        END LOOP;

        -----------------------------------------------------------------------
        -- This last WAIT statement needs to be here to prevent the PROCESS
        -- sequence from restarting.
        -----------------------------------------------------------------------
        WAIT;
        
    END PROCESS stimulus;

END ARCHITECTURE test;
