`ifndef _{:UPPERNAME:}_SEQ__SV_
`define _{:UPPERNAME:}_SEQ__SV_

class {:NAME:}_seq extends uvm_sequence #({:NAME:}_seq_item);

    //Using this will not have uvm print function.
    `uvm_object_utils({:NAME:}_seq)

    // Methods
    function new (string name="{:NAME:}_seq");
        super.new(name);
    endfunction

    extern task body;

endclass

////////////////////////////////////////////////////////////////////////////////
// Implementation
//------------------------------------------------------------------------------
task {:NAME:}_seq::body;

    `uvm_info(get_type_name(), $sformatf("Starting Sequenece"), UVM_HIGH)
    //using macro do all
    `uvm_do(req)

    //Macro Way 1
    //`uvm_do_with(req,{req.wr_en == 1;})
    
    //Macro Way 2
    //`uvm_create(req)
    //assert(req.randomize());
    //`uvm_send(req); 
    
    //Macro Way 3
    //`uvm_create(req)
    //`uvm_rand_send(req) 

    //Macro Way 4
    //`uvm_create(req)
    //`uvm_rand_send_with(req,{req.rd_en == 1;})

    //using start/finish
    //req = {:NAME:}_seq_item::type_id::create("req");
    //start_item(req);
    //if (!req.randomize()) begin
    //    `uvm_error(get_type_name(), "randomization failure for req")
    //end
    //finish_item(req); 
    //get_response(rsp); //optional

    //if repeat multiple time
    //{:NAME:}_seq_item req_template;
    //req_template = {:NAME:}_seq_item::type_id::create("req_template");
    //$cast(req, req_template.clone());
    //start_item(req);
    //if (!req.randomize()) begin
    //    `uvm_error(get_type_name(), "randomization failure for req")
    //end
    //finish_item(req); 

    //Get response
    //req = {:NAME:}_seq_item::type_id::create("req");
    //wait_for_grant();
    //if (req.randomize() with { ... })begin
    //    `uvm_error(get_type_name(), "randomization failure for req")
    //end
    //send_request(req);
    //wait_for_item_done();
    //get_response(res); //optional

    `uvm_info(get_type_name(), $sformatf("Sequenece done"), UVM_HIGH)

endtask

`endif
