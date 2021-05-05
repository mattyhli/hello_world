`ifndef _{:UPPERNAME:}_CFG__SV_
`define _{:UPPERNAME:}_CFG__SV_
class {:NAME:}_env_cfg extends uvm_object;

    `uvm_object_utils({:NAME:}_env_cfg)

    //template agent used this.
    bit has_functional_coverage = 1;

    //template env used this
    rand {:CPUIF:}_agent_cfg m_{:CPUIF:}_cfg;


    function new(string name = "{:NAME:}_env_cfg");
        super.new(name);
        m_{:CPUIF:}_cfg = {:CPUIF:}_agent_cfg::type_id::create("m_{:CPUIF:}_cfg");
    endfunction

    function void pre_randomize();
        super.pre_randomize();
    endfunction

    function void post_randomize();
        super.post_randomize();
    endfunction
endclass
`endif

