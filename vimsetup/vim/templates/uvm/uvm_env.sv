`ifndef _{:UPPERNAME:}_ENV__SV_
`define _{:UPPERNAME:}_ENV__SV_

class {:NAME:}_env extends uvm_env;

    `uvm_component_utils({:NAME:}_env)

    {:NAME:}_env_cfg m_cfg;
    {:NAME:}_vsqr m_vsqr;

    {:CPUIF:}_agent m_{:CPUIF:}_agent;

    //REG_MODEL TODO
    //{:NAME:}_reg_model reg_model;
    //reg_to_{:CPUIF:}_adapter reg2{:CPUIF:};
    //uvm_reg_predictor#({:CPUIF:}_seq_item) {:CPUIF:}_predictor;
    
    function new(input string name, input uvm_component parent=null);
      super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        if (m_cfg == null) begin
            if (!uvm_config_db#({:NAME:}_env_cfg)::get(this, "", "m_cfg", m_cfg)) begin
                `uvm_info(get_type_name(), "No {:NAME:}_env_cfg available, creating...", UVM_LOW)
                m_cfg = {:NAME:}_env_cfg::type_id::create("m_cfg", this);
                `uvm_info(get_type_name(), {"Printing m_cfg:\n", m_cfg.sprint()}, UVM_MEDIUM)
                if(!m_cfg.randomize()) begin
                    `uvm_error(get_type_name(), "m_cfg randomize failed")
                end
            end
        end
        uvm_config_db#({:CPUIF:}_agent_cfg)::set(this, "m_{:CPUIF:}_agent*", "m_cfg", m_cfg.m_{:CPUIF:}_cfg);
    

        //REG_MODEL TODO
        //if (m_cfg.reg_model == null) begin
        //    reg_model = {:NAME:}_reg_model::type_id::create("reg_model");
        //    reg_model.build();
        //    reg_model.lock_model();
        //    m_cfg.reg_model = reg_model;
        //end
    
        //REG_MODEL TODO
        //If there is a register model. Used create at next block and comment out this one
        m_{:CPUIF:}_agent = {:CPUIF:}_agent::type_id::create("m_{:CPUIF:}_agent",this);
        //if (reg_model.get_parent() == null) begin
        //    m_{:CPUIF:}_agent = {:CPUIF:}_agent::type_id::create("m_{:CPUIF:}_agent",this);
        //    //if (m_cfg.coverage_enable == 1) uvm_reg::include_coverage("*", UVM_CVR_ALL);
        //    reg2{:CPUIF:} = reg_to_{:CPUIF:}_adapter::type_id::create("reg2{:CPUIF:}");
        //    {:CPUIF:}_predictor = uvm_reg_predictor#({:CPUIF:}_seq_item)::type_id::create("{:CPUIF:}_predictor", this);
        //end
    
        m_vsqr = {:NAME:}_vsqr::type_id::create("m_vsqr",this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        //REG_MODEL TODO
        //if (reg_model.get_parent() == null) begin
        //    reg_model.default_map.set_sequencer(m_{:CPUIF:}_agent.master.sequencer, reg2{:CPUIF:});
        //    {:CPUIF:}_predictor.map = reg_model.default_map;
        //    {:CPUIF:}_predictor.adapter = reg2{:CPUIF:};
        //    m_{:CPUIF:}_agent.bus_monitor.ap.connect({:CPUIF:}_predictor.bus_in);
        //end
    
        m_vsqr.m_{:CPUIF:}_sqr = m_{:CPUIF:}_agent.m_sqr;
        
    endfunction
endclass
`endif
