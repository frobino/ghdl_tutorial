ECHO 

ghdl -a vga640_480.vhd
ghdl -a tb_vga.vhd

ghdl -e tb_vga
ghdl -r tb_vga --stop-time=2000000ns --vcd=tb_vga.vcd

gtkwave tb_vga.vcd