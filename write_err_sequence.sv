///////////////////////////////////////////////////////////////////////////////
// File:        write_err_sequence.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: Scenario to write data in wrong addr to toggel an error for APB RAM
///////////////////////////////////////////////////////////////////////////////
`ifndef WRITE_ERR_SEQUENCE_SV
    `define WRITE_ERR_SEQUENCE_SV
class write_err_sequence extends uvm_sequence#(transaction);
//Factory
`uvm_object_utils(write_err_sequence)
//Instances
transaction tr;
//Constructor
function new(string name = "write_err_sequence");
super.new(name);
endfunction
//Body
task body();
// Create a transaction
repeat (15) begin
    tr = transaction::type_id::create("tr");
    tr.addr_c.constraint_mode(0);//enable 
    tr.addr_c_err.constraint_mode(1);//disable
    start_item(tr);
    assert (tr.randomize()); 
    tr.op = writed;
    finish_item(tr);
end
endtask
endclass
`endif