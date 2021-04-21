`ifndef _{:UPPERNAME:}_SCOREBOARD__SV_
`define _{:UPPERNAME:}_SCOREBOARD__SV_

class {:NAME:}_scoreboard extends uvm_scoreboard;

    // This TLM port is used to connect the scoreboard to the monitor
    uvm_analysis_imp#({:TRANS:}, {:NAME:}_scoreboard) imp;
    
    // Provide UVM automation and utility methods
    `uvm_component_utils({:NAME:}_scoreboard)
    
    // Constructor - required syntax for UVM automation and utilities
    function new (string name, uvm_component parent);
        super.new(name, parent);
        // Construct the TLM interface
        imp = new("imp", this);
    endfunction
    
    // write method must implement for 
    extern virtual function void write({:TRANS:} transfer);
   
endclass

// TLM write() implementation
function void {:NAME:}_scoreboard::write({:TRANS:} transfer);
endfunction : write

`endif
