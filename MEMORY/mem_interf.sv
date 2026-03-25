interface mem_interf(input reg clk,res);
    logic wr_rd;
    logic [`ADDR_SIZE-1:0]addr;
    logic [`WIDTH-1:0]wdata;
    logic [`WIDTH-1:0]rdata;
    logic valid,ready;

    clocking dri_cb @(posedge clk);
        default input #0 output #1;
        input rdata,ready;
        output wr_rd,addr,wdata,valid;
    endclocking

    clocking mon_cb @(posedge clk);
        default input#1;
        input wr_rd,addr,wdata,rdata,valid,ready;
    endclocking

endinterface 
