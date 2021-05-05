`ifndef _{:UPPERNAME:}_SCOREBOARD__SV_
`define _{:UPPERNAME:}_SCOREBOARD__SV_

class {:NAME:}_scoreboard extends uvm_scoreboard;

    uvm_analysis_imp#({:NAME:}_seq_item, {:NAME:}_scoreboard) imp;
    
    `uvm_component_utils({:NAME:}_scoreboard)
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
        imp = new("imp", this);
    endfunction
    
    virtual function void write({:NAME:}_seq_item transfer);
    endfunction
   
endclass


`endif
