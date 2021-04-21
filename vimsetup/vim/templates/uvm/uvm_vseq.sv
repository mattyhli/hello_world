`ifndef _{:UPPERNAME:}_VSEQ__SV_
`define _{:UPPERNAME:}_VSEQ__SV_

class {:NAME:}_vseq extends {:PNAME:};

    //Using this will not have uvm print function.
    `uvm_object_utils({:NAME:}_vseq)

    //Virtual Sequencer (Collection of sequencers)
    //We do this at base virtual sequence
    //`uvm_declare_p_sequencer(uart_ctrl_virtual_sequencer)

    //Child sequence we can call some sequence inside this vseq
    // APB sequences
    //apb_config_seq config_seq;
    //apb_a2u_seq a2u_seq;
    // UART sequences
    //uart_u2a_seq u2a_seq;

    // Methods
    function new (string name="{:NAME:}_vseq");
        super.new(name);
    endfunction

    extern task body;

endclass

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
task {:NAME:}_vseq::body;
    //uvm_reg_data_t desired_value;
    //uvm_reg_data_t rdata;
    //uvm_reg_data_t wdata;
    //uvm_status_e status;

    //base virtual sequenece do nothing or just init stuff.

    `uvm_info(get_type_name(), $sformatf("Starting Sequenece"), UVM_HIGH)
    //a2u_seq = apb_a2u_seq::type_id::create("a2u_seq");
    //a2u_seq.randomize();
    //a2u_seq.start(vsqr.apb_seqr);

    //u2a_seq = uart_u2a_seq::type_id::create("u2a_seq");
    //u2a_seq.randomize();
    //u2a_seq.start(vsqr.uart_seqr);

    //Register
    //m_cfg.reg_model.....path.write(status, wdata);
    //m_cfg.reg_model.....path.read(status, rdata);

    //desired_value  = m_cfg.reg_model.....path.field.get();
    //m_cfg.reg_model.....path.field.set(1);
    //m_cfg.reg_model.....path.update(status);



    `uvm_info(get_type_name(), $sformatf("Sequenece done"), UVM_HIGH)

endtask

`endif
