///////////////////////////////////////////////////////////////////////////////
// File:        subscriber.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_subscriber class implementation for Functional Coverage
///////////////////////////////////////////////////////////////////////////////
`ifndef SUBSCRIBER_SV
    `define SUBSCRIBER_SV
class subscriber extends uvm_subscriber#(transaction);
//Factory
`uvm_component_utils(subscriber)
//Instances
transaction tr;
real cov;

covergroup cg_cov @(tr);
option.per_instance = 1;
option.name = "cov";
//coverpoint tr.PWDATA
COV1: coverpoint tr.PWDATA;
//coverpoint tr.PADDR
COV2: coverpoint (tr.PADDR) {
    
          bins address[] = {[0:31]}; 
}
endgroup


//Constructor
function new(string name = "subscriber", uvm_component parent = null);
super.new(name, parent);
cg_cov = new();
endfunction
//Write function 
function void write(transaction t);
    tr=t;
    cg_cov.sample();
endfunction
//Extract Phase
virtual function void extract_phase(uvm_phase phase);
super.extract_phase(phase);
cov = cg_cov.get_coverage();
endfunction
//Report Phase
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Functional Coverage is %0.2f%%", cov), UVM_LOW)
  endfunction
endclass
`endif 