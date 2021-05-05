`ifndef _{:UPPERNAME:}_MONITOR__SV_
`define _{:UPPERNAME:}_MONITOR__SV_

class {:NAME:}_monitor extends uvm_monitor;

    `uvm_component_utils({:NAME:}_monitor)

    uvm_analysis_port #({:NAME:}_seq_item) ap;

    virtual {:NAME:}_intf vif;
    {:NAME:}_agent_cfg m_cfg;
    
    protected int unsigned num_transactions = 0;
    
    {:NAME:}_seq_item trans_collected;
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (m_cfg == null) begin
            if (!uvm_config_db#({:NAME:}_agent_cfg)::get(this, "", "m_cfg", m_cfg)) begin
                `uvm_error(get_type_name(), "{:NAME:}_agent_cfg not set for this component")
            end
        end
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual {:NAME:}_intf)::get(this, "", "vif", vif)) begin
            `uvm_error(get_type_name(), {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end
    endfunction
    
    virtual task run_phase(uvm_phase phase);
    endtask
    
    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("The {:NAME:}_monitor collected %0d {:NAME:}_seq_item", num_transactions), UVM_LOW);
    endfunction
endclass
`endif 
