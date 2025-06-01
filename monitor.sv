///////////////////////////////////////////////////////////////////////////////
// File:        monitor.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_monitor class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef MONITOR_SV
    `define MONITOR_SV
class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
// virtual interface
virtual apb_if vif;
uvm_analysis_port#(transaction) send;
transaction tr;
// constructor
function new(string name = "monitor", uvm_component parent = null);
super.new(name, parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tr =  transaction::type_id::create("tr", this);
send = new("send", this);
// get the virtual interface
if(!uvm_config_db#(virtual apb_if)::get( null, "", "vif", vif )) 
`uvm_error("MONITOR", "Failed to get virtual interface")
endfunction
//Run Phase
virtual task run_phase(uvm_phase phase);
forever begin
    @(posedge vif.pclk);
    if (!vif.presetn) begin
        tr.op = rst;
        `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);    
        send.write(tr);
    end
     else if (vif.presetn && vif.pwrite)
         begin
          @(negedge vif.pready);
          tr.op     = writed;
          tr.PWDATA = vif.pwdata;
          tr.PADDR  =  vif.paddr;
          tr.PSLVERR  = vif.pslverr;
          `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d slverr:%0d",tr.PADDR,tr.PWDATA,tr.PSLVERR), UVM_NONE); 
          send.write(tr);
         end
      else if (vif.presetn && !vif.pwrite)
         begin
           @(negedge vif.pready);
          tr.op     = readd; 
          tr.PADDR  =  vif.paddr;
          tr.PRDATA   = vif.prdata;
          tr.PSLVERR  = vif.pslverr;
          `uvm_info("MON", $sformatf("DATA READ addr:%0d data:%0d slverr:%0d",tr.PADDR, tr.PRDATA,tr.PSLVERR), UVM_NONE); 
          send.write(tr);
         end
    
    end
   endtask 
endclass
`endif 