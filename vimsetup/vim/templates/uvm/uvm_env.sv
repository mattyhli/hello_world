`ifndef _{:UPPERNAME:}_ENV__SV_
`define _{:UPPERNAME:}_ENV__SV_

class {:NAME:}_env extends uvm_env;

    // Configurations object
    {:NAME:}_config m_cfg;
    
    //UVC Components
    {:CPUIF:}_pkg::{:CPUIF:}_agent   {:CPUIF:}0; // {:CPUIFUPPER:} UVC
    //uart_pkg::uart_agent uart0; // UART UVC
    //uart_ctrl_env      uart_ctrl0; // Module UVC
    
    // Virtual sequencer
    {:NAME:}_virtual_sequencer virtual_sequencer;
    
    // UVM_REG - Register Model
    {:NAME:}_reg_model reg_model;    // Register Model

    // Adapter sequence and predictor
    reg_to_{:CPUIF:}_adapter reg2{:CPUIF:};   // Adapter Object REG to {:CPUIFUPPER:}
    uvm_reg_predictor#({:CPUIF:}_seq_item) {:CPUIF:}_predictor;  // Precictor - {:CPUIFUPPER:} to REG
    
    `uvm_component_utils({:NAME:}_env)
    
    // Constructor - required UVM syntax
    function new(input string name, input uvm_component parent=null);
      super.new(name,parent);
    endfunction
    
    // Additional class methods
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass

function void {:NAME:}_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // get configur or create it.
    if (m_cfg == null) begin
        if (!uvm_config_db#({:NAME:}_config)::get(this, "", "m_cfg", m_cfg)) begin
            `uvm_info(get_type_name(), "No {:NAME:}_config available, creating...", UVM_LOW)
            m_cfg = {:NAME:}_config::type_id::create("m_cfg", this);
            `uvm_info(get_type_name(), {"Printing m_cfg:\n", m_cfg.sprint()}, UVM_MEDIUM)
        end
    end

    //UVM_REG - Create and configure the register model
    if (m_cfg.reg_model == null) begin
        // Only enable reg model coverage if enabled for the testbench
        reg_model = {:NAME:}_reg_model::type_id::create("reg_model");
        reg_model.build();  //NOTE: not same as build_phase: reg_model is an object
        reg_model.lock_model();
    end

    //assign register model to m_cfg
    m_cfg.reg_model = reg_model;

    //Put configure reference to sub-components. 
    //need sub-module used uvm_field_*. It hurts performance. 
    //Try assign afer create in build phase
    //uvm_config_object::set(this, "{:CPUIF:}0", "m_cfg", m_cfg.{:CPUIF:}_cfg);
    //uvm_config_object::set(this, "uart0", "m_cfg", m_cfg.uart_cfg);
    //uvm_config_object::set(this, "uart_ctrl0", "m_cfg", m_cfg);
    //uvm_config_object::set(this, "virtual_sequencer", "m_cfg", m_cfg);
    //uvm_config_object::set(this, "uart_ctrl0", "{:CPUIF:}_slave_cfg", cfg.{:CPUIF:}_cfg.slave_configs[0]);


    //We should used base_test put following code. test will not be re-used.
    //Keep it here in case we need this.
    if (reg_model.get_parent() == null) begin
        //if (coverage_enable == 1) uvm_reg::include_coverage("*", UVM_CVR_ALL);
        reg2{:CPUIF:} = reg_to_{:CPUIF:}_adapter::type_id::create("reg2{:CPUIF:}");
        {:CPUIF:}_predictor = uvm_reg_predictor#({:CPUIF:}_seq_item)::type_id::create("{:CPUIF:}_predictor", this);
    end
    
    // set the register model for the rest of the testbench
    // maybe should hide into each module's cfg with correct hirachary. 
    // uvm_config_object::set(this, "*", "reg_model", reg_model);
    
    // Create {:CPUIFUPPER:}, UART, Module UVC and Virtual Sequencer
    {:CPUIF:}0              = {:CPUIF:}_pkg::{:CPUIF:}_agent::type_id::create("{:CPUIF:}0",this);
    //uart0             = uart_pkg::uart_env::type_id::create("uart0",this);
    //uart_ctrl0        = uart_ctrl_env::type_id::create("uart_ctrl0",this);



    virtual_sequencer = {:NAME:}_virtual_sequencer::type_id::create("virtual_sequencer",this);

    //Put configure reference to sub-components. 
    //It avoid uvm_field_* 
    {:CPUIF:}0.m_cfg = m_cfg.m_{:CPUIF:}_cfg;
    //uart0.cfg = m_cfg.uart_cfg;

endfunction

  // UVM connect_phase
function void {:NAME:}_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //UVM_REG - set the sequencer and adapter for the register model
    
    if (reg_model.get_parent() == null) begin
        reg_model.default_map.set_sequencer({:CPUIF:}0.master.sequencer, reg2{:CPUIF:});  //
        {:CPUIF:}_predictor.map = reg_model.default_map;
        {:CPUIF:}_predictor.adapter = reg2{:CPUIF:};
    end

    // ***********************************************************
    //  Hookup virtual sequencer to interface sequencers
    // ***********************************************************
    virtual_sequencer.{:CPUIF:}_seqr = {:CPUIF:}0.master.sequencer;
    //virtual_sequencer.uart_seqr =  uart0.Tx.sequencer;
    
    //SETUP THE UART SLAVE CONFIG
    //uart_ctrl0.set_slave_config(cfg.{:CPUIF:}_cfg.slave_configs[0], 0);
    
    // ***********************************************************
    // ***********************************************************
    // Connect TLM ports
    // ***********************************************************
    //uart0.Rx.monitor.frame_collected_port.connect(uart_ctrl0.monitor.uart_rx_in);
    //uart0.Tx.monitor.frame_collected_port.connect(uart_ctrl0.monitor.uart_tx_in);
    //{:CPUIF:}0.bus_monitor.ap.connect(uart_ctrl0.monitor.{:CPUIF:}_in);
    //{:CPUIF:}0.bus_monitor.ap.connect(uart_ctrl0.{:CPUIF:}_in);
    //predictor two options.
    //predictor connect to sub-block predictor
    //{:CPUIF:}0.bus_monitor.ap.connect(uart_ctrl0.{:CPUIF:}_predictor.bus_in);
    //predictor connect to predictor here
    {:CPUIF:}0.bus_monitor.ap.connect({:CPUIF:}_predictor.bus_in);
    
    // ***********************************************************
    // Connect the dut_cfg ports
    // ***********************************************************
    //uart_ctrl0.uart_cfg_out.connect(uart0.dut_cfg_port_in);

endfunction

`endif
