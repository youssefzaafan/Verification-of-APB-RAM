///////////////////////////////////////////////////////////////////////////////
// File:        env.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_env class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef ENV_SV
    `define ENV_SV
class env extends uvm_env;
`uvm_component_utils(env)
//Instances
agent ag;
scoreboard scb;
subscriber sub;
// constructor
function new(string name = "env",uvm_component parent);
    super.new(name,parent);
endfunction
// build phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
// create agent and scoreboard instances
ag = agent::type_id::create("ag",this);
scb = scoreboard::type_id::create("scb",this);
sub = subscriber::type_id::create("sub",this);
endfunction
//Connect Phase
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
// connect agent and scoreboard
ag.mon.send.connect(scb.recv);
ag.mon.send.connect(sub.analysis_export);
endfunction
endclass
`endif 