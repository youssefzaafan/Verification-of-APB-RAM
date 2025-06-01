///////////////////////////////////////////////////////////////////////////////
// File:        scoreboard.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: uvm_scoreboard class implementation
///////////////////////////////////////////////////////////////////////////////
`ifndef SCOREBOARD_SV
    `define SCOREBOARD_SV
class scoreboard extends uvm_scoreboard;
//Factory
`uvm_component_utils(scoreboard)
//Instances
  uvm_analysis_imp#(transaction,scoreboard) recv;
  bit [31:0] arr[32] = '{default:0};
  bit [31:0] addr    = 0;
  bit [31:0] data_rd = 0;

//Constructor 
function new(string name = "scoreboard", uvm_component parent = null);
super.new(name, parent);
recv = new("recv", this);
endfunction
//Write method to Checking the data read from the DUT
function void write(transaction tr);
if (tr.op == rst) begin
    `uvm_info("SCO", "SYSTEM RESET DETECTED", UVM_NONE);
end
else if (tr.op == writed) begin
    if (tr.PSLVERR == 1'b1) begin
        `uvm_info("SCO", "SLV ERROR during WRITE OP", UVM_NONE);
    end
    else begin
        arr[tr.PADDR] = tr.PWDATA;
        `uvm_info("SCO", $sformatf("DATA WRITE OP  addr:%0d, wdata:%0d arr_wr:%0d",tr.PADDR,tr.PWDATA,  arr[tr.PADDR]), UVM_NONE);
    end
end
else if (tr.op == readd) begin
               if(tr.PSLVERR == 1'b1) begin
                `uvm_info("SCO", "SLV ERROR during READ OP", UVM_NONE);
                end
                else begin
                    data_rd = arr[tr.PADDR];
                if (data_rd == tr.PRDATA)
                 	`uvm_info("SCO", $sformatf("DATA MATCHED : addr:%0d, rdata:%0d",tr.PADDR,tr.PRDATA), UVM_NONE)
                else
                    `uvm_info("SCO",$sformatf("TEST FAILED : addr:%0d, rdata:%0d data_rd_arr:%0d",tr.PADDR,tr.PRDATA,data_rd), UVM_NONE) 
                end

    end
    $display("----------------------------------------------------------------");

endfunction
endclass
`endif 