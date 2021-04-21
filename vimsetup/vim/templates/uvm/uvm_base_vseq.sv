`ifndef _{:UPPERNAME:}_BASE_VSEQ__SV_
`define _{:UPPERNAME:}_BASE_VSEQ__SV_

class {:NAME:}_base_vseq extends uvm_sequnece;
    //This is a virtual sequence. We don't need a special seq_item

    //Using this will not have uvm print function.
    `uvm_object_utils({:NAME:}_base_vseq)

    //Virtual Sequencer (Collection of sequencers)
    //We do this at base virtual sequence
    //`uvm_declare_p_sequencer(uart_ctrl_virtual_sequencer)
    //macro is expensive.
    //Implement a init_vseq at base_test to do the connection.
    //Need to carefull control m_cfg between block level/ss level
    {:NAME:}_virtual_sequencer vsqr;
    {:NAME:}_env_config m_cfg;
    //For DUT init sequence (register read/write the DUT.)
    //Maybe we just used uvm_sequence as parent
    //Put register model inside and test need to put right path to seq.

    // Methods
    function new (string name="{:NAME:}_base_vseq");
        super.new(name);
    endfunction

endclass

`endif
