class mem_env extends uvm_env;
    `uvm_component_utils(mem_env)
    `COM
    mem_agent agent;
    mem_scb scb; 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent=mem_agent::type_id::create("agent",this);
        scb=mem_scb::type_id::create("scb",this);
        `uvm_info("ENV","BUILD_PHASE",UVM_NONE)

    endfunction

    function void connect_phase(uvm_phase phase);
        `uvm_info("ENV","CONNECT_PHASE",UVM_NONE)
        agent.mon.ap_port.connect(scb.ap_export);

    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info("ENV","END_OF_ELABORATION",UVM_NONE)
    endfunction

    function void start_of_stimulation_phase(uvm_phase phase);
        `uvm_info("ENV","START_OF_STIMULATION",UVM_NONE)
    endfunction


    task run_phase(uvm_phase phase);
        `uvm_info("ENV","RUN_PHASE",UVM_NONE)
    endtask

endclass
