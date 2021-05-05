`ifndef _{:UPPERNAME:}_BASE_TEST__SV_
`define _{:UPPERNAME:}_BASE_TEST__SV_

class {:NAME:}_base_test extends uvm_test;

    `uvm_component_utils({:NAME:}_base_test)
    
    //test class only handle top level clk/reset stuff.
    //Others should hide inside env for re-used purpose.

    {:NAME:}_agent m_env;
    {:NAME:}_agent_cfg m_env_cfg;
    {:NAME:}_sqr m_env_sqr;


    function new(string name = "{:NAME:}_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        m_env_cfg = {:NAME:}_agent_cfg::type_id::create("m_env_cfg");
        uvm_config_db#({:NAME:}_agent_cfg)::set(this, "m_env*", "m_cfg", m_env_cfg);
    
        m_env = {:NAME:}_agent::type_id::create("m_env", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        m_env_sqr = m_env.m_sqr;
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this, "Test Started");

        phase.drop_objection(this, "Test Finished");
    endtask
endclass
`endif
