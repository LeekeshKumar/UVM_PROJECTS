class base_test extends uvm_test;
    `uvm_component_utils(base_test)
    `COM
    mem_env env;
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env=mem_env::type_id::create("env",this);
        `uvm_info("RUN_TEST","BUILD_PHASE",UVM_NONE)

    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info("RUN_TEST","END_OF_ELABORATION",UVM_NONE)
        uvm_top.print_topology();
    endfunction

    function void start_of_stimulation_phase(uvm_phase phase);
        `uvm_info("RUN_TEST","START_OF_STIMULATION",UVM_NONE)
    endfunction
endclass

class wr_test extends base_test;
    `uvm_component_utils(wr_test)
    `COM
    mem_sequence sequ;

    task run_phase(uvm_phase phase);
        sequ=mem_sequence::type_id::create("sequence");
        phase.raise_objection(this);
        sequ.start(env.agent.seq);
        phase.phase_done.set_drain_time(this,150);
        phase.drop_objection(this);
    endtask
endclass

class Nw_Nr extends base_test;
    `uvm_component_utils(Nw_Nr)
    `COM

    mem_sequence sequ;

    task run_phase(uvm_phase phase);
        sequ=mem_sequence::type_id::create("sequence");
        phase.raise_objection(this);
        sequ.start(env.agent.seq);
        phase.phase_done.set_drain_time(this,150);
        phase.drop_objection(this);
    endtask

    function void report_phase(uvm_phase phase);
        if(com::mis_matching==0	&& com::matching==`N)begin
            `uvm_info("test_run","it will happen",UVM_NONE);
            $display("mismatch = %0d matching = %0d",com::mis_matching,com::matching);
        end else begin
            `uvm_info("test_run","it will not happen",UVM_NONE);
            $display("mismatch = %0d matching = %0d",com::mis_matching,com::matching);
        end
    endfunction

endclass
