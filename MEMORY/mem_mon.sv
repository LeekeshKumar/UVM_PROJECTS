class mem_mon extends uvm_monitor;
    `uvm_component_utils(mem_mon)
    `COM

    mem_tx tx;

    virtual mem_interf vif;

    uvm_analysis_port#(mem_tx)ap_port;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(virtual mem_interf)::get(this,"","vif",vif);
        ap_port=new("as_port",this);
    endfunction

    task run_phase(uvm_phase phase);
        //	 tx=new("mon_tx",this);
        // tx =mem_tx::type_id::create("mon_tx");

        forever begin
            @(vif.mon_cb);
            if(vif.mon_cb.valid && vif.mon_cb.ready)begin
                tx =mem_tx::type_id::create("scb_tx");
                tx.wr_rd =vif.mon_cb.wr_rd;
                tx.addr =vif.mon_cb.addr;
                if(tx.wr_rd==1)begin
                    tx.wdata= vif.mon_cb.wdata;
                end 
                else begin
                    tx.rdata = vif.mon_cb.rdata;		 
                end
                ap_port.write(tx);
                //tx.print();
                //ap_port.write(tx);
            end

        end
        // tx.print();

    endtask

endclass
