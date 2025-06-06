///////////////////////////////////////////////////////////////////////////////
// File:        agent.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_agent class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef AGENT_SV
    `define AGENT_SV
class agent extends uvm_agent;
//Factory 
`uvm_component_utils(agent)
//Instances
driver drv;
monitor mon;
uvm_sequencer#(transaction) seqr;
agent_config cfg;
//Constructor
function new(string name = "agent", uvm_component parent = null);
    super.new(name,parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //Create driver, monitor, and sequencer
    cfg = agent_config::type_id::create("cfg");
    mon = monitor::type_id::create("mon",this);
    if (cfg.is_active == UVM_ACTIVE) begin
    drv = driver::type_id::create("drv",this);
    seqr = uvm_sequencer#(transaction)::type_id::create("seqr",this);
    end
endfunction
//Connect Phase
virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(cfg.is_active == UVM_ACTIVE) begin  
        drv.seq_item_port.connect(seqr.seq_item_export);
    end
endfunction
endclass
`endif 