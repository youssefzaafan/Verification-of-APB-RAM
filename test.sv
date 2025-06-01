///////////////////////////////////////////////////////////////////////////////
// File:        test.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_test class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef TEST_SV
    `define TEST_SV
class test extends uvm_test;
//Factory
`uvm_component_utils(test)
//Instances
env e;
write_data_sequence wds;
read_data_sequence rds;
write_read_sequence wrs;
writeb_readb_sequence wrb_rbs;
write_err_sequence wer;
read_err_sequence rer;
//Constructor
function new(string name = "test", uvm_component parent = null);
super.new(name, parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
//Create the environment
e = env::type_id::create("e", this);
//Create the sequences
wds = write_data_sequence::type_id::create("wds");
rds = read_data_sequence::type_id::create("rds");
wrs = write_read_sequence::type_id::create("wrds");
wrb_rbs = writeb_readb_sequence::type_id::create("wrb_rbs");
wer = write_err_sequence::type_id::create("wer");
rer = read_err_sequence::type_id::create("rer");
endfunction
//Run Phase
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
//Run the sequences
wds.start(e.ag.seqr);
#20
phase.drop_objection(this);
endtask
endclass
`endif 