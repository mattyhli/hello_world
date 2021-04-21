`ifndef _{:UPPERNAME:}_TEST__SV_
`define _{:UPPERNAME:}_TEST__SV_


class {:NAME:}_test extends {:PNAME:}_base_test;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils({:NAME:}_test)

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "{:NAME:}_test", uvm_component parent = null);
  extern task run_phase(uvm_phase phase);

endclass: {:NAME:}_test

function {:NAME:}_test::new(string name = "{:NAME:}_test", uvm_component parent = null);
  super.new(name, parent);

  
  //Override type here
  //set_type_override_by_type(origin...get_type(), new...get_type());

  //Print out for debug
  //uvm_vactory factory;
  //factory = uvm_factory::get();
  //factory.print();

endfunction

task {:NAME:}_test::run_phase(uvm_phase phase);

    super.run_phase();

    //sample_seq_a seq_a = sample_seq_a::type_id::create("seq_a");
    //init_vseq(seq_a);
    //sample_seq_a seq_b = sample_seq_b::type_id::create("seq_a");
    //init_vseq(seq_b);
    
    phase.raise_objection(this, "Test Started");
    //seq_a.start();
    //#100;
    //seq_b.start();
    //#100;
    phase.drop_objection(this, "Test Finished");

endtask

`endif
