`ifndef SEQ_SV
`define SEQ_SV

import "DPI-C" function int sum_object_add(input int a, input int b);
import "DPI-C" function int sum_object_getSum();

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq)

  int last_sum;
   
  //Constructor
  function new(string name = "seq");
    super.new(name);
    last_sum = 0;
  endfunction
  
  virtual task body();
        req = seq_item::type_id::create("req");    //create the req (seq item)
        wait_for_grant();                          //wait for grant
        req.rdata = last_sum;
        send_request(req);                         //send req to driver
        wait_for_item_done();                      //wait for item done from driver
  endtask

  function int get_next_seqr_target();
    if(sum_object_add(0, 1)) begin
      last_sum = sum_object_getSum();
      if((last_sum % 2) == 0) begin
        return 0;
      end else
      begin
        return 1;
      end
    end
    return -1;
  endfunction : get_next_seqr_target
endclass

`endif