`ifndef _{:UPPERNAME:}_CFG__SV_
`define _{:UPPERNAME:}_CFG__SV_
class {:NAME:}_cfg extends uvm_object;

    `uvm_object_utils({:NAME:}_config)

    function new(string name = "{:NAME:}_config");
        super.new(name);
    endfunction

    function pre_randomize();
        super.pre_randomize();
    endfunction

    function post_randomize();
        super.post_randomize();
    endfunction
endclass
`endif

