`ifndef _{:UPPERNAME:}_BASE_TEST__SV_
`define _{:UPPERNAME:}_BASE_TEST__SV_

class {:NAME:}_base_test extends uvm_test;

    // UVM Factory Registration Macro
    //
    `uvm_component_utils({:NAME:}_base_test)
    
    //------------------------------------------
    // Data Members
    //------------------------------------------
    
    //------------------------------------------
    // Component Members
    //------------------------------------------
    // The environment class
    {:NAME:}_env m_env;
    // Configuration objects
    {:NAME:}_env_config m_env_cfg;
    {:CPUIF:}_agent_config m_{:CPUIF:}_cfg;
    {:ANAME:}_agent_config m_{:ANAME:}_cfg;
    // Register map
    {:NAME:}_reg_model {:NAME:}_reg_h;

    //Interface
    //virtual my_interface m_my_interface[3];

    //Interrupt Utility
    //intr_util INTR; //interface with task/function/utility.
    
    //------------------------------------------
    // Methods
    //------------------------------------------
    // Standard UVM Methods:
    function new(string name = "{:NAME:}_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    extern function void build_phase(uvm_phase phase);
    extern function void init_vseq({:NAME:}_base_vseq seq);

endclass: {:NAME:}_base_test

// Build the env, create the env configuration
// including any sub configurations and assigning virtural interfaces
function void {:NAME:}_base_test::build_phase(uvm_phase phase);

    super.build_phase(phase);
    // Interupt will not be reused. Put it in test 
    // virtual intr_bfm temp_intr_bfm;

    // env configuration
    m_env_cfg = {:NAME:}_env_config::type_id::create("m_env_cfg");
    // Register model
    // Enable all types of coverage available in the register model
    uvm_reg::include_coverage("*", UVM_CVR_ALL);
    // Create the register model:
    {:NAME:}_reg_h = {:NAME:}_reg_model::type_id::create("{:NAME:}_reg_h");
    // Build and configure the register model and utility.
    {:NAME:}_reg_h.build();
    {:NAME:}_reg_h.lock_model();
    
    // Assign a handle to the register model in the env config
    m_env_cfg.{:NAME:}_reg_h = {:NAME:}_reg_h;

    //{:CPUIFUP:}  configuration and setup vif.
    //Here they put vif direct into cfg.
    //m_{:CPUIF:}_cfg = {:CPUIF:}_agent_config::type_id::create("m_{:CPUIF:}_cfg");
    //configure_{:CPUIF:}_agent(m_{:CPUIF:}_cfg);
    //if (!uvm_config_db #(virtual {:CPUIF:}_monitor_vif)::get(this, "", "{:CPUIF:}_mon_vif", m_{:CPUIF:}_cfg.mon_vif))
    //    `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface {:CPUIF:}_mon_vif from uvm_config_db. Have you set() it?")
    //if (!uvm_config_db #(virtual {:CPUIF:}_driver_vif) ::get(this, "", "{:CPUIF:}_drv_vif", m_{:CPUIF:}_cfg.drv_vif))
    //    `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface {:CPUIF:}_drv_vif from uvm_config_db. Have you set() it?")
    //m_env_cfg.m_{:CPUIF:}_agent_cfg = m_{:CPUIF:}_cfg;

    // The {:ANAMEUP:} is not configured as such
    //m_{:ANAME:}_cfg = {:ANAME:}_agent_config::type_id::create("m_{:ANAME:}_cfg");
    //if (!uvm_config_db #(virtual {:ANAME:}_monitor_vif)::get(this, "", "{:ANAME:}_mon_vif", m_{:ANAME:}_cfg.mon_vif))
    //    `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface {:ANAME:}_mon_vif from uvm_config_db. Have you set() it?")
    //if (!uvm_config_db #(virtual {:ANAME:}_driver_vif) ::get(this, "", "{:ANAME:}_drv_vif", m_{:ANAME:}_cfg.drv_vif))
    //    `uvm_fatal("VIF CONFIG", "Cannot get() BFM interface {:ANAME:}_drv_vif from uvm_config_db. Have you set() it?")
    //m_{:ANAME:}_cfg.has_functional_coverage = 0;
    //m_env_cfg.m_{:ANAME:}_agent_cfg = m_{:ANAME:}_cfg;
    

    //Used for loop to get mutliple interface    
    //check uvm_interface.sv
    //for(int i=0; i<3; i++) begin
    //    if(!uvm_config_db#(virtual my_interface)::get(this, "", $sformatf("my_interface%0d", i) , m_my_interface[i])) begin
    //      `uvm_error(get_type_name(), $sformatf("uvm_config_db get my_interface%0d failed.", i))
    //    end else begin
    //      `uvm_info(get_type_name(), $sformatf("uvm_config_db get my_interface%0d", i), UVM_LOW)
    //    end
    //end

    //Insert the interrupt virtual interface into the env_config:
    //INTR = intr_util::type_id::create("INTR");
    //if (!uvm_config_db #(virtual intr_bfm)::get(this, "", "INTR_bfm", temp_intr_bfm) )
    //    `uvm_fatal("VIF CONFIG", "Cannot get() interface INTR_bfm from uvm_config_db. Have you set() it?")
    //INTR.set_bfm(temp_intr_bfm);
    //m_env_cfg.INTR = INTR;
    
    //wildcard * is easier to use. It will affect performance
    //uvm_config_db #({:NAME:}_env_config)::set(this, "*", "{:NAME:}_env_config", m_env_cfg);
    uvm_config_db #({:NAME:}_env_config)::set(this, "m_env", "{:NAME:}_env_config", m_env_cfg);
    m_env = {:NAME:}_env::type_id::create("m_env", this);


endfunction

function void {:NAME:}_base_test::init_vseq({:NAME:}_base_vseq seq);
    seq.vsqr = env.virtual_sequencer;
    seq.m_cfg = m_env_cfg;
endfunction

`endif
