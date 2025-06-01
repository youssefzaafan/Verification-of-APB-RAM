///////////////////////////////////////////////////////////////////////////////
// File:        writeb_readb_sequence.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: Scenario to write bulk data then read it from APB RAM
///////////////////////////////////////////////////////////////////////////////
`ifndef WRITEB_READB_SEQUENCE_SV
    `define WRITEB_READB_SEQUENCE_SV
class writeb_readb_sequence extends uvm_sequence#(transaction);
//Factory
`uvm_object_utils(writeb_readb_sequence)
//Instances
transaction tr;
//Constructor
function new(string name = "writeb_readb_sequence");
super.new(name);
endfunction
//Body
task body();
// Write bulk data to APB RAM
repeat (15) begin
    tr = transaction::type_id::create("tr");
    tr.addr_c.constraint_mode(1);//enable 
    tr.addr_c_err.constraint_mode(0);//disable
    start_item(tr);
    assert (tr.randomize()); 
    tr.op = writed;
    finish_item(tr);
end
//Read sequence
  repeat (15) begin
    tr = transaction::type_id::create("tr");
    tr.addr_c.constraint_mode(1);//enable 
    tr.addr_c_err.constraint_mode(0);//disable
    start_item(tr);
    assert (tr.randomize()); 
    tr.op = readd;
    finish_item(tr);
end
endtask
endclass
`endif