`ifndef _{:UPPERNAME:}_INTERFACE__SV_
`define _{:UPPERNAME:}_INTERFACE__SV_
//We should include this file in hvl_top.sv
//Make sure import uvm_pkg::*; before include
//This do 3 things
//1. Instantiate vif
//2. uvm_config_db set to right context.
//3. Connect vif to wires if needed.(option)

///////////////////////////
//Single instance
///////////////////////////
{:NAME:}_vif m_{:NAME:}_vif(clk, reset);
initial begin
  uvm_config_db #(virtual {:NAME:}_vif)::set(uvm_root::get(), "uvm_test_top", "{:NAME:}_vif", m_{:NAME:}_vif);
end

//Connect the wire for DUT.
//{:NAME:}_vif.valid = valid;
//{:NAME:}_vif.data = data;
///////////////////////////
//Multiple instance
///////////////////////////
//genvar idx;
//for(idx = 0; idx < 3; idx++) begin  : vif_inst
//  {:NAME:}_vif m_{:NAME:}_vif();
//  initial begin
//      uvm_config_db #(virtual {:NAME:}_vif)::set(uvm_root::get(),"uvm_test_top",$sformatf("{:NAME:}_vif%0d",idx),m_{:NAME:}_vif);
//  end
//  m_vif.data = data[idx];
//end

//assign outside gen block
//assign vif_inst[0].m_vif.data = data[0];
//assign data[0] = vif_inst[0].m_vif.data ;

`endif
