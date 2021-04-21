`ifndef REG2{:UPPERNAME:}_ADAPTER__SV
`define REG2{:UPPERNAME:}_ADAPTER__SV

class reg2{:NAME:}_adapter extends uvm_reg_adapter;

  `uvm_object_utils(reg2{:NAME:}_adapter)

   function new(string name = "reg2{:NAME:}_adapter");
      super.new(name);
   endfunction 

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    {:NAME:}_seq_item {:NAME:};

    {:NAME:} = {:NAME:}_seq_item::type_id::create("{:NAME:}");
    {:NAME:}.kind = (rw.kind == UVM_READ) ? {:NAME:}_seq_item::READ : {:NAME:}_seq_item::WRITE;
    {:NAME:}.addr = rw.addr;
    {:NAME:}.data = rw.data;

    return {:NAME:};
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    {:NAME:}_seq_item {:NAME:};

    if (!$cast({:NAME:},bus_item)) begin
      `uvm_fatal("NOT_APB_TYPE","Provided bus_item is not of the correct type")
      return;
    end
    rw.kind = {:NAME:}.kind == {:NAME:}_seq_item::READ ? UVM_READ : UVM_WRITE;
    rw.addr = {:NAME:}.addr;
    rw.data = {:NAME:}.data;
    rw.status = UVM_IS_OK;
  endfunction

endclass


`endif
