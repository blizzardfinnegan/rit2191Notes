--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*********  Copyright 2017, Rochester Institute of Technology  ***************
--*****************************************************************************
--
--  DESIGNER NAME:  Jeanne
--
--       LAB NAME:  Counters and Timers with VHDL II
--
--      FILE NAME:  Soda_tb
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This test bench will provide input to test the implemention of the 
--    Soda display design. The Soda Display should scroll "ICE COLD SODA SOLD HERE"
--    on the six seven segment displays at a 1 second interval.
--    This is not a self checking testbench which allows the designer to choose 
--    their own message if they so desire.
--
--    This testbench puts the Soda Display in the test mode (100 ns) so the output
--    will change every 5 clock cycles. It is impossible to test the other modes 
--    of operation due to the high number of clock pulses required to change the 
--    output.
--
--    
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 10/30/17 | JWC  | 1.0 | Created 
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY Soda_tb IS
END Soda_tb;


ARCHITECTURE test OF soda_tb IS

   -- Component Declaration for the Unit Under Test (UUT)
   -- if you use a package with the component defined then you do not need this
   COMPONENT scrolling_display IS
      PORT(clk, reset_n	         	: IN STD_LOGIC;
            S								: IN STD_LOGIC;
            -------------------------------------------------------------------
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5	: OUT STD_LOGIC_VECTOR(6 downto 0));
   END COMPONENT;

   -- define signals for component ports
   -- Inputs
   SIGNAL clk_tb    : std_logic := '0';
   SIGNAL reset_n_tb : std_logic := '0';
   signal S_tb       : std_logic := '0';
   --
   -- Outputs

   SIGNAL hex0_tb        : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex1_tb        : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex2_tb        : std_logic_vector(6 DOWNTO 0);
	 SIGNAL hex3_tb        : std_logic_vector(6 DOWNTO 0);
   SIGNAL hex4_tb        : std_logic_vector(6 DOWNTO 0);
	 SIGNAL hex5_tb        : std_logic_vector(6 DOWNTO 0);
   

   -- signals for test bench control
   SIGNAL sim_done : boolean := false;
   SIGNAL PERIOD_c : time    := 20 ns;  -- 50MHz
	
	

BEGIN  -- test

   -- component instantiation
   UUT : Scrolling_display
      PORT MAP (
						clk    => clk_tb,
						reset_n => reset_n_tb,
						S       => S_tb,
         --
					
						hex0        => hex0_tb,
						hex1        => hex1_tb,
						hex2        => hex2_tb,
						hex3	      => hex3_tb,
            hex4        => hex4_tb,
						hex5	      => hex5_tb
         );

   -- This creates an clock_50 that will shut off at the end of the Simulation
   -- this makes a clock_50 that you can shut off when you are done.
   clk_tb <= NOT clk_tb AFTER PERIOD_C/2 WHEN (NOT sim_done) ELSE '0';


   ---------------------------------------------------------------------------
   -- NAME: Stimulus
   --
   -- DESCRIPTION:
   --    This process will apply stimulus to the UUT.
   ---------------------------------------------------------------------------
   stimulus : PROCESS
   
   BEGIN
      -- de-assert all inputs except the reset which is asserted
      reset_n_tb <= '0';
      WAIT FOR 5 ns;

      -- now lets sync the stimulus to the clock_50
      -- move stimulus 1ns after clock edge
      WAIT UNTIL clk_tb = '1';

      -- de-assert reset 
      reset_n_tb <= '1';
		-- allow the BCD counter to count to max value
		-- convert the hex outputs back to BDC digits
		--convert the BCD digits to an integer number
		--compare the number against the loop counter
		for i in 0 to 30 loop
		    wait for 5*PERIOD_C;
			 
		end loop;   

      -- shutting down simulation
      sim_done <= true;
      WAIT FOR PERIOD_c*1;
		report "Simulation Complete";
      -----------------------------------------------------------------------
      -- This Last WAIT statement needs to be here to prevent the PROCESS
      -- sequence from re starting.
      -----------------------------------------------------------------------
      WAIT;
   END PROCESS stimulus;

	
		

END test;
