`ifndef _{:UPPERNAME:}_FCOV_MON__SV
`define _{:UPPERNAME:}_FCOV_MON__SV

class {:NAME:}_fcov_mon extends uvm_subscriber #({:TRANS:});

    `uvm_component_utils({:NAME:}_fcov_mon)

    {:TRANS:} fcov_item;

    covergroup {:NAME:}_cg;
        option.name = "{:NAME:}_fcov_mon_group";
        option.comment = "";
        option.per_instance = 0;

        //added coverpoint here
        //Copy some example from uvm_cookbook.
        //s:  coverpoint  fcov_item.src_id { 
        //    bins  src[8]  =  {[0:7]}; 
        //} 
        //d:  coverpoint  fcov_item.dest_id {
        //    bins  dest[8]  =  {[0:7]};
        //}
    endgroup

    function new(string name, uvm_component parent);
        super.new(name,parent);
        {:NAME:}_cg = new();
    endfunction // new
    
    extern function void write(input transaction t);
endclass

function void {:NAME:}_fcov_mon::write(input {:TRANS:} t);

    `uvm_info(m_name, $sformatf("Received: %s", t.convert2string()), UVM_MEDIUM)
    fcov_item = t;
    {:NAME:}_cg.sample();

endfunction
`endif
