class mem_dri extends uvm_driver#(mem_tx);
    `uvm_component_utils(mem_dri)
    `COM

    virtual mem_interf vif;

    //map  the interface the thing we use the config tb in build phase

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual mem_interf)::get(this,"","vif",vif);

        `uvm_info("DRI","BUILD_PHASE",UVM_NONE)
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info("DRI","RUN_PHASE",UVM_NONE)
        forever begin
            seq_item_port.get_next_item(req);
            drive_tx(req);
            req.print();
            seq_item_port.item_done();
        end
    endtask

    task drive_tx(mem_tx tx);
        @(vif.dri_cb); 
        vif.dri_cb.valid    <= 1;
        vif.dri_cb.wr_rd    <= tx.wr_rd;
        vif.dri_cb.addr     <= tx.addr;
        if(tx.wr_rd==1)
            vif.dri_cb.wdata    <= tx.wdata;
        else vif.dri_cb.wdata <=0;
        wait(vif.dri_cb.ready==1);

        @(vif.dri_cb);
        vif.dri_cb.valid    <= 0;
        vif.dri_cb.addr     <= 0;
        vif.dri_cb.wdata    <= 0;

        @(vif.dri_cb);
        if(tx.wr_rd==0)begin
            tx.rdata 	= vif.dri_cb.rdata;
            tx.wdata 	=0;
        end else tx.rdata <=0;


    endtask

endclass


