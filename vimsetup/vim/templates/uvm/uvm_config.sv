`ifndef _{:UPPERNAME:}_CFG__SV_
`define _{:UPPERNAME:}_CFG__SV_
class {:NAME:}_cfg extends uvm_object;

    //template agent used this.
    bit has_functional_coverage = 1;

    `uvm_object_utils({:NAME:}_cfg)

    function new(string name = "{:NAME:}_cfg");
        super.new(name);
    endfunction

    function void pre_randomize();
        super.pre_randomize();
    endfunction

    function void post_randomize();
        super.post_randomize();
    endfunction
endclass
`endif

