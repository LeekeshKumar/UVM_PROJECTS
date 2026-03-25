class mem_scb extends uvm_scoreboard;
    `uvm_component_utils(mem_scb)
    `COM
    mem_tx q[$];
    //mem_tx q_temp;
    static bit[31:0] mem[int];

    uvm_analysis_imp#(mem_tx,mem_scb) ap_export;


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_export=new("ap_export",this);
    endfunction

    virtual function void write(mem_tx tx);
        mem_tx stx;
        //  stx =mem_tx::type_id::create("scb_tx");
        $cast(stx,tx);
        stx.print();
        q.push_back(stx);
    endfunction

    task run_phase(uvm_phase phase);
        mem_tx tx;

        forever begin
            wait(q.size() !=0);

            tx= q.pop_front();

            if(tx.wr_rd==1)begin
                mem[tx.addr]=tx.wdata;
            end
            else begin
                //if(tx.wr_rd==0)begin
                if(tx.rdata == mem[tx.addr])begin
                    com::matching++;
                end 
                else begin
                    com::mis_matching++;
                end
            end

        end

    endtask


endclass
