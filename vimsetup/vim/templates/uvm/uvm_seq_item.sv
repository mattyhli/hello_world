`ifndef _{:UPPERNAME:}_SEQ_ITEM__SV_
`define _{:UPPERNAME:}_SEQ_ITEM__SV_

class {:NAME:}_seq_item extends uvm_sequence_item;

    `uvm_object_utils_begin({:NAME:}_seq_item)
    `uvm_object_utils_end

    function new(string name="{:NAME:}_seq_item");
        super.new(name);
    endfunction 

endclass 
`endif
