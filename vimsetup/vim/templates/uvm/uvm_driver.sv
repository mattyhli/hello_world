`ifndef _{:UPPERNAME:}_DRIVER__SV_
`define _{:UPPERNAME:}_DRIVER__SV_

// CLASS: {:NAME:}_driver declaration
class {:NAME:}_driver extends uvm_driver #({:REQ:}_seq_item);
    // The virtual interface used to drive and view HDL signals.
    virtual {:REQ:}_if vif;
    
    // A pointer to the configuration unit of the agent
    {:REQ:}_config m_cfg;
    
    // Provide implementations of virtual methods such as get_type_name and create
    // used field macro is costly. Avoid
    `uvm_component_utils({:NAME:}_driver)
    
    // Constructor which calls super.new() with appropriate parameters.
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    // class methods
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
endclass

// UVM build_phase
function void {:NAME:}_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (m_cfg == null) begin
        if (!uvm_config_db#({:REQ:}_config)::get(this, "", "{:REQ:}_config", m_cfg)) begin
            `uvm_error(get_type_name(), "{:REQ:}_config not set for this component")
        end
    end
endfunction

// UVM connect_phase - gets the vif as a config property
function void {:NAME:}_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual {:REQ:}_if)::get(this, "", "{:REQ:}_if", vif)) begin
        `uvm_error(get_type_name(),{"virtual interface must be set for: ",get_full_name(),".vif"})
    end
endfunction

// Declaration of the UVM run_phase method.
task {:NAME:}_driver::run_phase(uvm_phase phase);

    //We should divid to several task. for reset/drive-data/idle and etc.

    //If we only send req without send back rsp
    //seq_item_port.get_next_item(req); //try_next_item(req)
    //driver_tranfer(req);
    //seq_item_port.item_done();

    //If we send req with rsp.
    //seq_item_port.get_next_item(req);
    //$cast(rsp, req.clone());
    //rsp.set_id_info(req);
    //driver_tranfer(rsp);
    //seq_item_port.item_done();
    //seq_item_port.put_response(rsp);

    //Mentor suggest anther method to get rsp
    //seq_item_port.get(req); //peek(req)
    //driver_tranfer(req);
    //$cast(rsp, req.clone());
    //rsp.set_id_info(req);
    //seq_item_port.item_done();
    //seq_item_port.put(rsp);


endtask


`endif 
