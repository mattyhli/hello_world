`ifndef _{:UPPERNAME:}_TB__SV_
`define _{:UPPERNAME:}_TB__SV_

module tb_top();

import uvm_pkg::*;
`include "uvm_macros.svh"
import {:NAME:}_test_pkg::*;

{:CPUIF:}_intf {:CPUIF:}_intf_inst();

initial begin
    uvm_config_db#(virtual {:CPUIF:}_intf)::set(uvm_root::get(), "uvm_test_top.m_env*", "vif", {:CPUIF:}_intf_inst);
end

initial begin
    run_test();
end

endmodule
`endif
