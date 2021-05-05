`ifndef _{:UPPERNAME:}_SCOREBOARD__SV_
`define _{:UPPERNAME:}_SCOREBOARD__SV_

//Should move to package not put here.
//If others scoreborad need this they just used it inside the class
`uvm_analysis_imp_decl(_{:TRANS1:})
`uvm_analysis_imp_decl(_{:TRANS2:})

class {:NAME:}_scoreboard extends uvm_scoreboard;

    uvm_analysis_imp_{:TRANS1:} #({:TRANS1:}, {:NAME:}_scoreboard) {:TRANS1:}_add;
    uvm_analysis_imp_{:TRANS2:} #({:TRANS2:}, {:NAME:}_scoreboard) {:TRANS2:}_match;
    
    `uvm_component_utils({:NAME:}_scoreboard)
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
        {:TRANS1:}_add = new("{:TRANS1:}_add", this);
        {:TRANS2:}_match = new("{:TRANS2:}_match", this);
    endfunction
    
    virtual function void write_{:TRANS1:}({:TRANS1:} transfer);
    endfunction

    virtual function void write_{:TRANS2:}({:TRANS2:} transfer);
    endfunction
   
endclass
`endif
