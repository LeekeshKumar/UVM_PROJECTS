`include "uvm_pkg.sv"
//`include "uvm_macros.svh"
import uvm_pkg::*;
`include "memory.v"
`include "common.sv"
`include "mem_tx.sv"
`include "mem_interf.sv"
`include "mem_sequence.sv"
`include "mem_seq.sv"
`include "mem_dri.sv"
`include "mem_mon.sv"
`include "mem_cov.sv"
`include "mem_agent.sv"
`include "mem_scb.sv"
`include "mem_env.sv"
`include "run_test.sv"
`include "mem_assertion.sv"


module tb;
    bit clk,res;

    mem_interf pif(clk,res);

    mem  dut(.clk(pif.clk),
        .res(pif.res),
        .wr_rd(pif.wr_rd),
        .addr(pif.addr),
        .wdata(pif.wdata),
        .rdata(pif.rdata),
        .valid(pif.valid),
        .ready(pif.ready));

        bind mem mem_asser m_assr(.clk(pif.clk),
            .res(pif.res),
            .wr_rd(pif.wr_rd),
            .addr(pif.addr),
            .wdata(pif.wdata),
            .rdata(pif.rdata),
            .valid(pif.valid),
            .ready(pif.ready));


            always #5 clk =~clk;

            initial begin
                clk=0;
                res=1;
                repeat(2)@(posedge clk)
                    res=0;
            end

            initial begin
                uvm_config_db#(virtual mem_interf)::set(null,"uvm_test_top.env.agent.*","vif",pif);
            end

            initial begin
                run_test("Nw_Nr");
            end

            initial begin
                #10000;
                $finish;
            end

endmodule

