`ifndef _{:UPPERNAME:}_TEST_PKG__SV_
`define _{:UPPERNAME:}_TEST_PKG__SV_

package {:NAME:}_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //import pkgs here
    import {:NAME:}_agent_pkg::*;

    //include sequence cross mutliple env ?

    //include base_test
    `include "{:NAME:}_base_test.sv"

    //include tests

endpackage
`endif
