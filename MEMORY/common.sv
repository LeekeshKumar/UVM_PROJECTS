
`define COM function new(string name="",uvm_component parent);super.new(name,parent);endfunction


`define OBJ function new(string name="");super.new(name);endfunction


`define WIDTH 8
`define DEPTH 32
`define ADDR_SIZE $clog2(`DEPTH)

`define N 2

class com;
static int matching;
static int mis_matching;

endclass
