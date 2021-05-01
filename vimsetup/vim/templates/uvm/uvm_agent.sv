`ifndef _{:UPPERNAME:}_AGENT__SV_
`define _{:UPPERNAME:}_AGENT__SV_

class {:NAME:}_agent extends uvm_agent;

    `uvm_component_utils({:NAME:}_agent)

    uvm_analysis_port #({:NAME:}_seq_item) ap;

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    {:NAME:}_agent_cfg m_cfg;
    
    {:NAME:}_monitor m_monitor;
    {:NAME:}_fcov m_fcov;
    {:NAME:}_driver m_driver;
    {:NAME:}_sequencer m_sqr;
    
    
    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (m_cfg == null) begin
            if (!uvm_config_db#({:NAME:}_agent_cfg)::get(this, "", "{:NAME:}_agent_cfg", m_cfg)) begin
                `uvm_error(get_type_name(), "{:NAME:}_agent_cfg not set for this component")
            end
        end
    
        m_monitor = {:NAME:}_monitor::type_id::create("m_monitor",this);
        if(is_active == UVM_ACTIVE) begin
          m_sqr = {:NAME:}_sequencer::type_id::create("m_sqr",this);
          m_driver = {:NAME:}_driver::type_id::create("m_driver",this);
        end
    
        if(m_cfg.has_functional_coverage)  begin 
            m_fcov  = {:NAME:}_fcov::type_id::create("m_fcov",  this);
        end
    endfunction
    
    virtual function void {:NAME:}_agent::connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        ap = m_monitor.ap;
        if (is_active == UVM_ACTIVE) begin
          m_driver.seq_item_port.connect(m_sqr.seq_item_export);
        end
    
        if(m_cfg.has_functional_coverage)  begin 
            m_monitor.ap.connect(m_fcov_monitor.analysis_export); 
        end
    endfunction 
endclass
`endif
