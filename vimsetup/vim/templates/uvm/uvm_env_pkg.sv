`ifndef _{:UPPERNAME:}_ENV_PKG__SV_
`define _{:UPPERNAME:}_ENV_PKG__SV_

package {:NAME:}_env_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "{:NAME:}_env_cfg.sv"
    `include "{:NAME:}_vsqr.sv"
    `include "{:NAME:}_env.sv"
endpackage
`endif
