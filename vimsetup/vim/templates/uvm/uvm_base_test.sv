`ifndef _{:UPPERNAME:}_BASE_TEST__SV_
`define _{:UPPERNAME:}_BASE_TEST__SV_

class {:NAME:}_base_test extends uvm_test;

    `uvm_component_utils({:NAME:}_base_test)
    
    //test class only handle top level clk/reset stuff.
    //Others should hide inside env for re-used purpose.

    {:NAME:}_env m_env;
    {:NAME:}_env_cfg m_env_cfg;

    virtual clk_rst_bfm clk_reset_vif;

    function new(string name = "{:NAME:}_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        if (!uvm_config_db#(virtual clk_rst_bfm)::get(this, "", "clk_rst_bfm", clk_reset_vif)) begin
            `uvm_error(get_type_name(), "clk_rst_bfm did not setup correctly at tb/uvm_test")
        end

        m_env_cfg = {:NAME:}_env_cfg::type_id::create("m_env_cfg");
        uvm_config_db#({:NAME:}_env_cfg)::set(this, "m_env", "m_cfg", m_env_cfg);
    
        m_env = {:NAME:}_env::type_id::create("m_env", this);
    endfunction

    function void build_phase(uvm_phase phase);
        clk_reset_vif.setting();
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase();
        phase.raise_objection(this, "Test Started");

        phase.drop_objection(this, "Test Finished");
    endtask
endclass: {:NAME:}_base_test
`endif
