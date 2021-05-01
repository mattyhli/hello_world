`ifndef _{:UPPERNAME:}_TB__SV_
`define _{:UPPERNAME:}_TB__SV_

module tb_top();

import uvm_pkg::*;
`include "uvm_macros.svh"

import {:NAME}_test_pkg::*;

{:ANAME:}_intf {:ANAME:}_intf_inst;

initial begin
    uvm_config_db#(virtual {:ANAME:}_intf)::set(uvm_root::get(), "uvm_test_top.env_h.{:ANAME:}_agent_h.driver", "vif", {ANAME:}_intf_inst.driver);
    //uvm_config_db#(virtual {:ANAME:}_intf.driver)::set(uvm_root::get(), "uvm_test_top.env_h.agent_h.driver", "vif", {ANAME:}_intf_inst);
    uvm_config_db#(virtual {:ANAME:}_intf)::set(uvm_root::get(), "uvm_test_top.env_h.{:ANAME:}_agent_h.monitor", "vif", {ANAME:}_intf_inst.monitor);
    //uvm_config_db#(virtual {:ANAME:}_intf.monitor)::set(uvm_root::get(), "uvm_test_top.env_h.agent_h.monitor", "vif", {ANAME:}_intf_inst);
    uvm_config_db#(virtual {:ANAME:}_intf)::set(uvm_root::get(), "uvm_test_top.env_h.{:ANAME:}_agent_h", "vif", {ANAME:}_intf_inst);
end

generate
    for( i = 0; i < 3; i++)  begin : vif_loop
        {:ANAME:}_intf {:ANAME:}_intf_inst;
    	initial begin
            uvm_config_db#(virtual {:ANAME:}_intf)::set(uvm_root::get(), $sformatf("uvm_test_top.env_h.{:ANAME:}_agent_h[%0d]", i), "vif", {ANAME:}_intf_inst);
    	end
    end
endgenerate

//assign vif_loop[0].{:ANAME:}_intf_inst.valid = valid;


endmodule
`endif
