`ifndef _{:UPPERNAME:}_TEST__SV_
`define _{:UPPERNAME:}_TEST__SV_


class {:NAME:}_test extends {:PNAME:}_test;

  `uvm_component_utils({:NAME:}_test)


    function new(string name = "{:NAME:}_test", uvm_component parent = null);
        super.new(name, parent);

    endfunction
    
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    
        phase.raise_objection(this, "{:NAME:}_test Started");

        phase.drop_objection(this, "{:NAME:}_test Finished");
    endtask
endclass: {:NAME:}_test


`endif
