`ifndef _{:UPPERNAME:}_SEQ__SV_
`define _{:UPPERNAME:}_SEQ__SV_

class {:NAME:}_seq extends uvm_sequence #({:REQ:}_seq_item);

    `uvm_object_utils({:NAME:}_seq)

    function new (string name="{:NAME:}_seq");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), $sformatf("Starting Sequenece"), UVM_HIGH)
    
        `uvm_info(get_type_name(), $sformatf("Sequenece done"), UVM_HIGH)
    endtask
endclass
`endif
