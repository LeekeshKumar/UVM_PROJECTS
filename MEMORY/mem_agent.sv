class mem_agent extends uvm_agent;
    `uvm_component_utils(mem_agent)
    `COM

    mem_seq seq;
    mem_dri dri;
    mem_mon mon;
    mem_cov cov;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq=mem_seq::type_id::create("seq",this);
        dri=mem_dri::type_id::create("dri",this);
        mon=mem_mon::type_id::create("mon",this);
        cov=mem_cov::type_id::create("cov",this);
        `uvm_info("agent","BUILD_PHASE",UVM_NONE)

    endfunction

    function void connect_phase(uvm_phase phase);
        `uvm_info("agent","CONNECT_PHASE",UVM_NONE)
        dri.seq_item_port.connect(seq.seq_item_export);
        mon.ap_port.connect(cov.analysis_export);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info("agent","END_OF_ELABORATION",UVM_NONE)
    endfunction

    function void start_of_stimulation_phase(uvm_phase phase);
        `uvm_info("agent","START_OF_STIMULATION",UVM_NONE)
    endfunction


    task run_phase(uvm_phase phase);
        `uvm_info("agent","RUN_PHASE",UVM_NONE)
    endtask


endclass

