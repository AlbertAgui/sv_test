`ifndef SEQ_SV
`define SEQ_SV

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq)

  int idx = 0;
   
  //Constructor
  function new(string name = "seq");
    super.new(name);
  endfunction
  
  virtual task body();
        req = seq_item::type_id::create("req");  //create the req (seq item)
        wait_for_grant();                            //wait for grant

        req.rdata = idx;
        ++idx;

        send_request(req);                           //send req to driver
        wait_for_item_done();                        //wait for item done from driver
  endtask

  function int get_idx();
    return idx;
  endfunction : get_idx
endclass

`endif