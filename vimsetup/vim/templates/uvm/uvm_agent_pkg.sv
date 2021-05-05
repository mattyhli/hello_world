`ifndef _{:UPPERNAME:}_AGENT_PKG__SV_
`define _{:UPPERNAME:}_AGENT_PKG__SV_

package {:NAME:}_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "{:NAME:}_seq_item.sv"
    `include "{:NAME:}_agent_cfg.sv"
    `include "{:NAME:}_sqr.sv"
    `include "{:NAME:}_driver.sv"
    `include "{:NAME:}_monitor.sv"
    `include "{:NAME:}_fcov.sv"
    `include "{:NAME:}_agent.sv"

    //include all sequence for this agent
endpackage
`include "{:NAME:}_intf.sv"

`endif
