ECHO 

REM The following lines include unisim packages (including "unisims/*.vhd" does not work on windows)
ghdl -a --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/unisim_retarget_VCOMP.vhd
ghdl -a --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/unisim_VPKG.vhd

REM The following lines include unisim components implementation, included in the design
REM Again, including "unisims/primitives/*.vhd" does not work on windows
ghdl -a --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/primitive/DCM_SP.vhd
ghdl -a --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/primitive/BUFG.vhd
ghdl -a --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/primitive/IBUF.vhd
ghdl -a --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/retarget/IBUFG.vhd

REM Analyze the user design
ghdl -a vga1024_768.vhd 
ghdl -a tb_vga.vhd 

REM Create executable for user design
ghdl -e -g -Punisim --warn-unused --ieee=synopsys tb_vga

REM Run the executable
ghdl -r tb_vga --disp-tree=inst --stop-time=20000ns --vcd=tb_vga.vcd

REM Start gtk
gtkwave tb_vga.vcd
