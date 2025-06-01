///////////////////////////////////////////////////////////////////////////////
// File:        driver.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_driver class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef DRIVER_SV
    `define DRIVER_SV
class driver extends uvm_driver#(transaction);
//Factory
`uvm_component_utils(driver)
//Instaces
transaction tr; 
virtual apb_if vif;
//Constructor
function new(string name = "driver", uvm_component parent = null);
super.new(name, parent);
endfunction
//Build Phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tr = transaction ::type_id::create("tr", this);
if(!uvm_config_db#(virtual apb_if)::get(null,"", "vif", vif ))
`uvm_error("DRV", "Failed to get vif from uvm_config_db")
endfunction
//Reset Logic
 task reset_dut();
    repeat(5) 
    begin
    vif.presetn   <= 1'b0;
    vif.paddr     <= 'h0;
    vif.pwdata    <= 'h0;
    vif.pwrite    <= 'b0;
    vif.psel      <= 'b0;
    vif.penable   <= 'b0; 
    `uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
    @(posedge vif.pclk);
    end
  endtask
  //drive logic
  task drive_dut();
   reset_dut();
   forever begin
         seq_item_port.get_next_item(tr);

    if (tr.op == rst) begin
        vif.presetn   <= 1'b0;
        vif.paddr     <= 'h0;
        vif.pwdata    <= 'h0;
        vif.pwrite    <= 'b0;
        vif.psel      <= 'b0;
        vif.penable   <= 'b0; 
        @(posedge vif.pclk);
    end
    else if (tr.op == writed) begin
                            vif.psel    <= 1'b1;
                            vif.paddr   <= tr.PADDR;
                            vif.pwdata  <= tr.PWDATA;
                            vif.presetn <= 1'b1;
                            vif.pwrite  <= 1'b1;
                            @(posedge vif.pclk);
                            vif.penable <= 1'b1;
     `uvm_info("DRV", $sformatf("mode:%0s, addr:%0d, wdata:%0d, rdata:%0d, slverr:%0d",tr.op.name(),tr.PADDR,tr.PWDATA,tr.PRDATA,tr.PSLVERR), UVM_NONE);
                            @(negedge vif.pready);
                            vif.penable <= 1'b0;
                            tr.PSLVERR   = vif.pslverr;

   end
   else if (tr.op == readd) begin
vif.psel    <= 1'b1;
                            vif.paddr   <= tr.PADDR;
                            vif.presetn <= 1'b1;
                            vif.pwrite  <= 1'b0;
                            @(posedge vif.pclk);
                            vif.penable <= 1'b1;
     `uvm_info("DRV", $sformatf("mode:%0s, addr:%0d, wdata:%0d, rdata:%0d, slverr:%0d",tr.op.name(),tr.PADDR,tr.PWDATA,tr.PRDATA,tr.PSLVERR), UVM_NONE);
                            @(negedge vif.pready);
                            vif.penable <= 1'b0;
                            tr.PRDATA     = vif.prdata;
                            tr.PSLVERR    = vif.pslverr;

   end
         seq_item_port.item_done();

   end
  endtask
  //Run Phase
  virtual task run_phase(uvm_phase phase);
    drive_dut();
  endtask
  endclass
`endif 