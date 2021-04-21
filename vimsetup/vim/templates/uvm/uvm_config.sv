`ifndef _{:UPPERNAME:}_CONFIG__SV_
`define _{:UPPERNAME:}_CONFIG__SV_

// Class Description
//
class {:NAME:}_config extends uvm_object;


    // Virtual Interface
    //

    //------------------------------------------
    // Data Members
    //------------------------------------------
    // active or passive
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    // include the functional coverage or not
    bit has_functional_coverage = 0;

    // include the scoreboard or not
    //bit has_scoreboard = 0;

    //If it is top level/sub system/agent
    //It can has other config
    //apb_master_config master_config;
    //apb_slave_config slave_configs[$];


    // UVM Factory Registration Macro
    // used field macro is costly. Avoid
    `uvm_object_utils({:NAME:}_config)


    //------------------------------------------
    // Constraint
    //------------------------------------------

    //------------------------------------------
    // Methods
    //------------------------------------------

    function new(string name = "{:NAME:}_config");
        super.new(name);
    endfunction

endclass

`endif

