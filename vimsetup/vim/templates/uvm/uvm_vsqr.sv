`ifndef _{:UPPERNAME:}_VSQR__SV_
`define _{:UPPERNAME:}_VSQR__SV_

class {:NAME:}_vsqr extends uvm_sequencer;
    
    `uvm_component_utils({:NAME:}_vsqr)

    {:CPUIF:}_sqr m_{:CPUIF:}_sqr;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass

`endif 
