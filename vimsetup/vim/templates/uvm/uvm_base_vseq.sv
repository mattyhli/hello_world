`ifndef _{:UPPERNAME:}_BASE_SEQ__SV_
`define _{:UPPERNAME:}_BASE_SEQ__SV_

class {:NAME:}_base_seq extends uvm_sequence;
    `uvm_object_utils({:NAME:}_base_seq)

    `uvm_declare_p_sequencer({:NAME:}_vsqr)

    function new (string name="{:NAME:}_base_seq");
        super.new(name);
    endfunction

    virtual task body();
    endtask
endclass

`endif
