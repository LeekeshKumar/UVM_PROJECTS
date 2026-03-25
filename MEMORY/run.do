vlog top.sv +incdir+C:/UVM/uvm-1.2/src
#coverage save 2-oneexits   .ucdb
vsim -coverage -novopt -suppress 12110 tb -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi  -assertdebug 
#add wave -r sim:/tb/*
do wave.do
run -all
