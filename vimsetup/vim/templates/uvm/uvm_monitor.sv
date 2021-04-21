`ifndef _{:UPPERNAME:}_MONITOR__SV_
`define _{:UPPERNAME:}_MONITOR__SV_

class {:NAME:}_monitor extends uvm_monitor;

    uvm_analysis_port #({:NAME:}_seq_item) ap;
    
    virtual {:NAME:}_if vif;
    {:NAME:}_config m_cfg;
    
    protected int unsigned num_transactions = 0;
    
    bit checks_enable = 1; 
    bit coverage_enable = 1;
    
    // The following property holds the transaction information currently
    // being captured (by the collect_address_phase and data_phase methods). 
    {:NAME:}_seq_item trans_collected;
    
    // Provide implementations of virtual methods such as get_type_name and create
    // used field macro is costly. Avoid
    `uvm_component_utils({:NAME:}_monitor)
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
        trans_collected = {:NAME:}_seq_item::type_id::create("trans_collected");
        ap = new("ap", this);
    endfunction : new
    
    // Additional class methods
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);

endclass

// UVM build_phase
function void {:NAME:}_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (m_cfg == null) begin
        if (!uvm_config_db#({:NAME:}_config)::get(this, "", "{:NAME:}_config", m_cfg)) begin
            `uvm_error(get_type_name(), "{:NAME:}_config not set for this component")
        end
    end
endfunction

// UVM connect_phase
function void {:NAME:}_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual {:NAME:}_if)::get(this, "", "{:NAME:}_if", vif)) begin
        `uvm_error(get_type_name(), {"virtual interface must be set for: ", get_full_name(), ".vif"})
    end
endfunction


// UVM run_phase()
task {:NAME:}_monitor::run_phase(uvm_phase phase);
    //waiting for reset done
    //forever loop start to collect info
    //write to ap
    ap.write(trans_collected);
    `uvm_info(get_type_name(), $sformatf("Transfer collected :\n%s", trans_collected.sprint()), UVM_MEDIUM)
    num_transactions++;
endtask

function void {:NAME:}_monitor::report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("The {:NAME:}_monitor collected %0d {:NAME:}_seq_item", num_transactions), UVM_LOW);
endfunction
`endif 
