///////////////////////////////////////////////////////////////////////////////
// File:        reset_dut_sequence.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: Scenario to write data in APB RAM
///////////////////////////////////////////////////////////////////////////////
`ifndef RESET_DUT_SEQUENCE_SV
    `define RESET_DUT_SEQUENCE_SV
class reset_dut_sequence extends uvm_sequence#(transaction);
//Factory
`uvm_object_utils(reset_dut_sequence)
//Instances
transaction tr;
//Constructor
function new(string name = "reset_dut_sequence");
super.new(name);
endfunction
//Body
task body();
// Create a transaction
repeat (15) begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        tr.addr_c_err.constraint_mode(0);
        
        start_item(tr);
        assert(tr.randomize);
        tr.op = rst;
        finish_item(tr);
end
endtask
endclass
`endif