`ifndef _{:UPPERNAME:}_FCOV__SV
`define _{:UPPERNAME:}_FCOV__SV

class {:NAME:}_fcov extends uvm_subscriber #({:NAME:}_seq_item);

    `uvm_component_utils({:NAME:}_fcov)

    {:NAME:}_seq_item fcov_item;

    covergroup {:NAME:}_cg;
        option.name = "{:NAME:}_fcov_group";
        option.comment = "";
        option.per_instance = 0;
    endgroup

    function new(string name, uvm_component parent);
        super.new(name,parent);
        {:NAME:}_cg = new();
    endfunction
    
    function void write(input {:NAME:}_seq_item t);
    
        `uvm_info(m_name, $sformatf("Received: %s", t.convert2string()), UVM_MEDIUM)
        fcov_item = t;
        {:NAME:}_cg.sample();
    
    endfunction
endclass

`endif
