`ifndef _{:UPPERNAME:}_SEQ_ITEM__SV_
`define _{:UPPERNAME:}_SEQ_ITEM__SV_

class {:NAME:}_seq_item extends uvm_sequence_item;

    //Field automation
    //check $UVM_HOME/uvm_object_defines.svh
    //Scalar: 
    //`uvm_field_int(ARG,FLAG)
    //`uvm_field_real(ARG,FLAG)
    //`uvm_field_enum(T,ARG,FLAG)
    //`uvm_field_object(ARG,FLAG)
    //`uvm_field_event(ARG,FLAG)
    //`uvm_field_string(ARG,FLAG)
    // FLAG:
    //   UVM_ALL_ON     - Set all operations on.
    //   UVM_DEFAULT    - This is the recommended set of flags
    //   UVM_NOCOPY     - Do not copy this field.
    //   UVM_NOCOMPARE  - Do not compare this field.
    //   UVM_NOPRINT    - Do not print this field.
    //   UVM_NOPACK     - Do not pack or unpack this field.

    //Used field macro is costly. But we did need copy/compare/print in most of case.
    //Used scalar and some simple stuff. 
    //`uvm_object_utils({:NAME:}_seq_item)
    `uvm_object_utils_begin({:NAME:}_seq_item)
    `uvm_object_utils_end

    function new(string name="{:NAME:}_seq_item");
        super.new(name);
    endfunction 

endclass 

`endif
