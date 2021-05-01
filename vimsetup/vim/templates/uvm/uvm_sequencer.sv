`ifndef _{:UPPERNAME:}_SQR__SV_
`define _{:UPPERNAME:}_SQR__SV_

class {:NAME:}_sqr extends uvm_sequencer #({:NAME:}_seq_item);
    
    `uvm_component_utils({:NAME:}_sqr)
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
endclass

`endif 
