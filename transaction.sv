`ifndef TRANSACTION_SV
`define TRANSACTION_SV

typedef enum bit [1:0] {readd = 0, writed = 1, rst = 2} oper_mode;

class transaction extends uvm_sequence_item;

    rand oper_mode         op;
         logic             PWRITE;
    rand logic [31 : 0]    PWDATA;
    rand logic [31 : 0]    PADDR;

    // Output Signals of DUT for APB UART's transaction
         logic             PREADY;
         logic             PSLVERR;
         logic [31: 0]     PRDATA;

    `uvm_object_utils_begin(transaction)
        `uvm_field_int(PWRITE, UVM_ALL_ON)
        `uvm_field_int(PWDATA, UVM_ALL_ON)
        `uvm_field_int(PADDR, UVM_ALL_ON)
        `uvm_field_int(PREADY, UVM_ALL_ON)
        `uvm_field_int(PSLVERR, UVM_ALL_ON)
        `uvm_field_int(PRDATA, UVM_ALL_ON)
        `uvm_field_enum(oper_mode, op, UVM_DEFAULT)
    `uvm_object_utils_end

    // Constraints
    constraint addr_c     { PADDR <= 31; }
    constraint addr_c_err { PADDR > 31; }

    // Constructor
    function new(string name = "transaction");
        super.new(name);
    endfunction

    // Function to copy another transaction
    function void do_copy(uvm_object rhs);
        transaction rhs_;
        if (!$cast(rhs_, rhs)) begin
            `uvm_fatal("COPY_FAILED", "Casting of rhs to transaction failed")
        end
        super.do_copy(rhs);
        this.op       = rhs_.op;
        this.PWRITE   = rhs_.PWRITE;
        this.PWDATA   = rhs_.PWDATA;
        this.PADDR    = rhs_.PADDR;
        this.PREADY   = rhs_.PREADY;
        this.PSLVERR  = rhs_.PSLVERR;
        this.PRDATA   = rhs_.PRDATA;
    endfunction

    // Function to return string representation for printing
    function string convert2string();
        return $sformatf("op = %s, PWRITE = %0b, PWDATA = %0h, PADDR = %0h, PREADY = %0b, PSLVERR = %0b, PRDATA = %0h",
                         op.name(), PWRITE, PWDATA, PADDR, PREADY, PSLVERR, PRDATA);
    endfunction

endclass

`endif
