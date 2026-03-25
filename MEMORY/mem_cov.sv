class mem_cov extends uvm_subscriber#(mem_tx);
    `uvm_component_utils(mem_cov)
    mem_tx tx;

    covergroup cg;
        coverpoint tx.wr_rd{
            bins WRITES = {1'b1};
        }
        coverpoint tx.wr_rd{
            bins READS = {1'b0};
        }
        coverpoint tx.addr{
            bins ADDR = {[0:`DEPTH]};
        }

    endgroup

    function new(string name="",uvm_component parent);
        super.new(name,parent);
        cg=new();
    endfunction




    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    virtual function void write(mem_tx t);
        $cast(tx,t);
        t.print();
        cg.sample();
    endfunction



    //schedule phase


endclass
