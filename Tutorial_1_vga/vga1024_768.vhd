
-- Additional Comments:
-- 
-- Pin Assignment:
-- MET clk50_in loc = T9
-- NET red_out LOC=R12; 
-- NET green_out LOC=T12;
-- NET blue_out LOC=R11;
-- NET hs_out LOC=R9; 
-- NET vs_out LOC=T10; 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

library UNISIM;
use UNISIM.Vcomponents.ALL;


entity vga_timing is
port(
    clk50_in 	: in std_logic;
    red_out 	: out std_logic;
    green_out 	: out std_logic;
    blue_out 	: out std_logic;
    hs_out 	: out std_logic;
    vs_out 	: out std_logic);
end vga_timing;

architecture behavioral of vga_timing is

signal clk75 		: std_logic;
signal CLK0_BUF        	: std_logic;
signal CLKFB_IN        	: std_logic;
signal hcounter 	: integer range 0 to 1328;
signal vcounter 	: integer range 0 to 806;
signal color		: std_logic_vector(2 downto 0):="111";
signal CLKIN_IBUFG     	: std_logic;
signal CLKFX_BUF     	: std_logic;
signal GND_BIT        	: std_logic;


begin

   GND_BIT <= '0';
	
   CLKIN_IBUFG_INST : IBUFG
      port map (I=>CLK50_in,
                O=>CLKIN_IBUFG);
 
   CLK0_BUFG_INST : BUFG
      port map (I=>CLK0_BUF,
                O=>CLKFB_IN);
 

   
   CLKFX_BUFG_INST : BUFG
      port map (I=>CLKFX_BUF,
                O=>CLK75);
   
  
  DCM_SP_INST : DCM_SP
   generic map( CLK_FEEDBACK => "1X",
            CLKDV_DIVIDE => 2.0,
            CLKFX_DIVIDE => 2,
            CLKFX_MULTIPLY => 3,
            CLKIN_DIVIDE_BY_2 => FALSE,
            CLKIN_PERIOD => 20.000,
            CLKOUT_PHASE_SHIFT => "NONE",
            DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE => "LOW",
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF => x"C080",
            PHASE_SHIFT => 0,
            STARTUP_WAIT => FALSE)
      port map (CLKFB=>CLKFB_IN,
                CLKIN=>CLKIN_IBUFG,
                DSSEN=>GND_BIT,
                PSCLK=>GND_BIT,
                PSEN=>GND_BIT,
                PSINCDEC=>GND_BIT,
                RST=>'0',
                CLKDV=>open,
                CLKFX=>CLKFX_BUF,
                CLKFX180=>open,
                CLK0=>CLK0_BUF,
                CLK2X=>open,
                CLK2X180=>open,
                CLK90=>open,
                CLK180=>open,
                CLK270=>open,
                LOCKED=>open,
                PSDONE=>open,
                STATUS=>open);




-- change color 
p1: process (clk75)
variable cnt: integer;
begin
if clk75'event and clk75='1' then
cnt := cnt + 1;
if cnt = 25000000 then
color <= std_logic_vector(unsigned(color) + 1); --color <= color + "001";
cnt := 0;
end if;
end if;
end process;

p2: process (clk75, hcounter, vcounter)
variable x: integer range 0 to 2000:=0;
variable y: integer range 0 to 2000:=0;
begin
x := hcounter ;
y := vcounter ;
if clk75'event and clk75 = '1' then
    if x < 1023 and y < 767 then
      red_out <= color(0);
      green_out <= color(1); 
      blue_out <= color(2);
    else
    -- if not traced, set it to "black" color
    red_out <= '0';
    green_out <= '0';
    blue_out <= '0';
    end if;

    if hcounter > 1047 and hcounter < 1185 then
	hs_out <= '0';
    else
	hs_out <= '1';
    end if;

    if vcounter > 770 and vcounter < 778 then
	vs_out <= '0';
    else
	vs_out <= '1';
    end if;
	hcounter <= hcounter+1;
    if hcounter = 1238 then
	vcounter <= vcounter+1;
	hcounter <= 0;
    end if;
--
    if vcounter = 806 then 
	vcounter <= 0;
    end if;
end if;
end process;

end behavioral;

