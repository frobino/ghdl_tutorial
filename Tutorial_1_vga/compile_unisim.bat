ECHO 

ghdl -i --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/unisim_retarget_VCOMP.vhd
ghdl -i --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/unisim_VPKG.vhd

ghdl -i --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/primitive/DCM_SP.vhd
ghdl -i --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/primitive/BUFG.vhd
ghdl -i --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/primitive/IBUF.vhd
ghdl -i --work=unisim C:/Xilinx/Vivado/2014.4/data/vhdl/src/unisims/retarget/IBUFG.vhd

ghdl -i vga1024_768.vhd 
ghdl -i tb_vga.vhd 

ghdl -m -g -Punisim --warn-unused --ieee=synopsys tb_vga

ghdl -r tb_vga --disp-tree=inst --stop-time=20000ns --vcd=tb_vga.vcd

gtkwave tb_vga.vcd
