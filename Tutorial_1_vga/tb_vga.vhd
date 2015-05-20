
-- simulation model for VGA

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_vga IS
END tb_vga;
 
ARCHITECTURE behavior OF tb_vga IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT vga_timing
    PORT(
         clk50_in  : IN  std_logic;
         red_out   : OUT  std_logic;
         green_out : OUT  std_logic;
         blue_out  : OUT  std_logic;
         hs_out    : OUT  std_logic;
         vs_out    : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk50_in : std_logic := '0';

 --Outputs
  
   signal red_out : std_logic;
   signal green_out : std_logic;
   signal blue_out : std_logic;
   signal hs_out : std_logic;
   signal vs_out : std_logic;

   -- Clock period definitions
   constant clk50_in_period : time := 10 ns;
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: vga_timing PORT MAP (
          clk50_in => clk50_in,
          red_out => red_out,
          green_out => green_out,
          blue_out => blue_out,
          hs_out => hs_out,
          vs_out => vs_out
        );

   -- Clock process definitions
   clk50_in_process :process
   begin
		clk50_in <= '0';
		wait for clk50_in_period/2;
		clk50_in <= '1';
		wait for clk50_in_period/2;
   end process;


END;
