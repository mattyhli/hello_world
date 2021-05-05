`ifndef _{:UPPERNAME:}_DRIVER__SV_
`define _{:UPPERNAME:}_DRIVER__SV_

class {:NAME:}_driver extends uvm_driver #({:NAME:}_seq_item);

    `uvm_component_utils({:NAME:}_driver)

    virtual {:NAME:}_intf vif;
    {:NAME:}_agent_cfg m_cfg;
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (m_cfg == null) begin
            if (!uvm_config_db#({:NAME:}_agent_cfg)::get(this, "", "m_cfg", m_cfg)) begin
                `uvm_error(get_type_name(), "{:NAME:}_agent_cfg not set for this component")
            end
        end
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual {:NAME:}_intf)::get(this, "", "vif", vif)) begin
            `uvm_error(get_type_name(),{"virtual interface must be set for: ",get_full_name(),".vif"})
        end
    endfunction
    
    virtual task run_phase(uvm_phase phase);
    endtask
endclass
`endif 
