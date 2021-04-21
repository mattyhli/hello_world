`ifndef _{:UPPERNAME:}_SQR__SV_
`define _{:UPPERNAME:}_SQR__SV_

// CLASS: {:NAME:}_sequencer declaration
class {:NAME:}_sequencer extends uvm_sequencer #({:REQ:}_seq_item);
    
    // We usually do nothing. But here is a place holder
    // You can put cfg/vif here if sequence needed.
    // If nothing needed we can just instantiate at env/agent
    // uvm_sequencer#({:REQ:}_seq_item) {:NAME:}_sequencer_h;

    // Provide implementations of virtual methods such as get_type_name and create
    `uvm_component_utils({:NAME:}_sequencer)
    
    // Constructor which calls super.new() with appropriate parameters.
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
endclass

`endif 
