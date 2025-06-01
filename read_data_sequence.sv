///////////////////////////////////////////////////////////////////////////////
// File:        read_data_sequence.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: Scenario to read data from APB RAM
///////////////////////////////////////////////////////////////////////////////
`ifndef READ_DATA_SEQUENCE_SV
    `define READ_DATA_SEQUENCE_SV
class read_data_sequence extends uvm_sequence#(transaction);
//Factory
`uvm_object_utils(read_data_sequence)
//Instances
transaction tr;
//Constructor
function new(string name = "read_data_sequence");
super.new(name);
endfunction
//Body
task body();
// Create a transaction
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