`ifndef _{:UPPERNAME:}_SCOREBOARD__SV_
`define _{:UPPERNAME:}_SCOREBOARD__SV_

//Better put following two line in packaage before this include
//If others scoreborad need this they just used it inside the class
`uvm_analysis_imp_decl(_{:TRANS1:})
`uvm_analysis_imp_decl(_{:TRANS2:})

class {:NAME:}_scoreboard extends uvm_scoreboard;

    // This TLM port is used to connect the scoreboard to the monitor
    //uvm_analysis_imp#({:TRANS:}, {:NAME:}_scoreboard) imp;
    uvm_analysis_imp_{:TRANS1:} #({:TRANS1:}, {:NAME:}_scoreboard) {:TRANS1:}_add;
    uvm_analysis_imp_{:TRANS2:} #({:TRANS2:}, {:NAME:}_scoreboard) {:TRANS2:}_match;
    
    // Provide UVM automation and utility methods
    `uvm_component_utils({:NAME:}_scoreboard)
    
    // Constructor - required syntax for UVM automation and utilities
    function new (string name, uvm_component parent);
        super.new(name, parent);
        {:TRANS1:}_add = new("{:TRANS1:}_add", this);
        {:TRANS2:}_match = new("{:TRANS2:}_match", this);
    endfunction
    
    // write method must implement for 
    extern virtual function void write_{:TRANS1:}({:TRANS1:} transfer);
    extern virtual function void write_{:TRANS2:}({:TRANS2:} transfer);
   
endclass

// TLM write() implementation
function void {:NAME:}_scoreboard::write_{:TRANS1:}({:TRANS1:} transfer);
endfunction

function void {:NAME:}_scoreboard::write_{:TRANS2:}({:TRANS2:} transfer);
endfunction


`endif
