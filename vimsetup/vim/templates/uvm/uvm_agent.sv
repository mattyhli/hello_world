`ifndef _{:UPPERNAME:}_AGENT__SV_
`define _{:UPPERNAME:}_AGENT__SV_

class {:NAME:}_agent extends uvm_agent;

    uvm_analysis_port #({:TRANS:}_seq_item) ap;

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    {:TRANS:}_config m_cfg;
    
    {:TRANS:}_monitor m_monitor;
    {:TRANS:}_fcov m_fcov;
    {:NAME:}_driver m_driver;

    //Two way to define {:NAME:}_sequencer
    //1. Define a class in another file (prefer)
    //   In case we need added config/vif or other stuff at sequencer.
    //2. Type define in package file
    //   typedef uvm_sequencer#({:TRANS:}_seq_item) {:NAME:}_sequencer;
    {:NAME:}_sequencer m_sequencer;
    
    // Provide implementations of virtual methods such as get_type_name and create
    // used field macro is costly. Avoid
    `uvm_component_utils({:NAME:}_agent)
    
    // new - constructor
    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
    
    // Additional class methods
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass

// UVM build_phase
function void {:NAME:}_agent::build_phase(uvm_phase phase);

    super.build_phase(phase);
    if (m_cfg == null) begin
        if (!uvm_config_db#({:TRANS:}_config)::get(this, "", "{:TRANS:}_config", m_cfg)) begin
            `uvm_error(get_type_name(), "{:TRANS:}_config not set for this component")
        end
    end

    //set is_active base on m_cfg.
    //is_active = m_cfg.is_active;
     
    m_monitor = {:TRANS:}_monitor::type_id::create("m_monitor",this);
    if(is_active == UVM_ACTIVE) begin
      m_sequencer = {:NAME:}_sequencer::type_id::create("m_sequencer",this);
      m_driver = {:NAME:}_driver::type_id::create("m_driver",this);
    end

    if(m_cfg.has_functional_coverage)  begin 
        m_fcov  = {:TRANS:}_fcov::type_id::create("m_fcov",  this);
    end

endfunction

// UVM connect_phase
function void {:NAME:}_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    ap = m_monitor.ap;

    if (is_active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end

    if(m_cfg.has_functional_coverage)  begin 
        m_monitor.ap.connect(m_fcov_monitor.analysis_export); 
    end
endfunction 
`endif
