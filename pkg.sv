///////////////////////////////////////////////////////////////////////////////
// File:        pkg.sv
// Author:      Youssef Zaafan Atya
// Date:        2025-06-1
// Description: onwed uvm pkage
///////////////////////////////////////////////////////////////////////////////
`include "uvm_macros.svh"

package pkg;
	import uvm_pkg::*;
`include "agent_config.sv"
`include "transaction.sv"
`include "write_data_sequence.sv"
`include "read_data_sequence.sv"
`include "write_read_sequence.sv"
`include "writeb_readb_sequence.sv"
`include "write_err_sequence.sv"
`include "read_err_sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"
endpackage