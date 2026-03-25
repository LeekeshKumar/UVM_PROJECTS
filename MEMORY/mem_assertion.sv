module mem_asser(clk,res,wr_rd,addr,wdata,rdata,valid,ready);

    input clk,res,wr_rd,valid;
    input [`WIDTH-1:0] wdata;
    input [`ADDR_SIZE-1:0] addr;
    input [`WIDTH-1:0] rdata;
    input ready;

    //sequence h_s;
    //valid ##0 ready;
    //endsequence

    //property handshaking;
    //valid |-> ready;
    //endproperty

    //assert property(handshaking);

    property write;
        @(posedge clk)(wr_rd && (!($isunknown(wdata))) && valid	&&	ready ) |-> wdata;

    endproperty

    assert property(write);

    property ready_r;
        @(posedge clk)(!wr_rd &&(!($isunknown(rdata))) &&valid && ready) |-> rdata;
    endproperty

    assert property(ready_r);

endmodule
