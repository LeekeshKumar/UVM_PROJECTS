class mem_sequence extends uvm_sequence#(mem_tx);
    `uvm_object_utils(mem_sequence)
    `OBJ
    task body();
        mem_tx txQ[$];
        mem_tx temp;
        repeat(`N)begin
            `uvm_do_with(req,{req.wr_rd==1;})
            txQ.push_back(req);
        end

        repeat(`N)begin
            temp=txQ.pop_front();
            `uvm_do_with(req,{req.wr_rd==0;req.addr==temp.addr;})
        end
    endtask



endclass

