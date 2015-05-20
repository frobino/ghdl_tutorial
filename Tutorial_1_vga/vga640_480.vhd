
-------------------------------------------------------------------------------
-- Dossmatik GmbH
-- http://www.dossmatik.de
--simple VGA example

-- Additional Comments:
-- 
--Spartan3AN board
-- Pin Assignment:
-- NET clk50_in loc = T9
-- NET red_out LOC=R12; 
-- NET green_out LOC=T12;
-- NET blue_out LOC=R11;
-- NET hs_out LOC=R9; 
-- NET vs_out LOC=T10; 
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity vga_timing is
port(
clk50_in : in std_logic;

red_out   : out std_logic;
green_out : out std_logic;
blue_out  : out std_logic;
hs_out : out std_logic;
vs_out : out std_logic);
end vga_timing;

architecture behavioral of vga_timing is

signal clk25 : std_logic:='0';
signal hcounter : unsigned (9 downto 0):=to_unsigned(0,10);
signal vcounter : unsigned (9 downto 0):=to_unsigned(0,10);

begin

-- generate a 25Mhz clock
process (clk50_in)
begin
if clk50_in'event and clk50_in='1' then
    clk25 <= not clk25;
end if;
end process;

process (clk25)
begin
if clk25'event and clk25 = '1' then
	if vcounter<480 then
	    if hcounter < 320 then
		  red_out<='1';
	     else
		red_out<='0';
	    end if;
	else
	    red_out<='0';
	end if;
end if;
end process;


process (clk25)
begin
if clk25'event and clk25 = '1' then
	if hcounter<640 then
	    if vcounter < 240 then
		  blue_out<='1';
	    else
		  blue_out<='0';
	    end if;
	    if vcounter > 120 and vcounter < 360 then
		  green_out<='1';
	    else
		  green_out<='0';
	    end if;
	else
	    blue_out<='0';
	    green_out<='0';
	end if;
end if;
end process;



process (clk25)
begin

if clk25'event and clk25 = '1' then

	if hcounter >= (639+16) and hcounter <= (639+16+96) then
		hs_out <= '0';
	else
		hs_out <= '1';
	end if;
	if vcounter >= (479+10) and vcounter <= (479+10+2) then
		vs_out <= '0';
	else
		vs_out <= '1';
	end if;
-- horizontal counts from 0 to 799
	hcounter <= hcounter+1;
	if hcounter = 799 then
		vcounter <= vcounter+1;
		hcounter <= to_unsigned(0,10);
	end if;
-- vertical counts from 0 to 524
	if vcounter = 524 then 
		vcounter <= to_unsigned(0,10);
	end if;
end if;
end process;

end behavioral;