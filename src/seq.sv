`ifndef SEQ_SV
`define SEQ_SV

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq)
   
  //Constructor
  function new(string name = "seq");
    super.new(name);
  endfunction
  
  virtual task body();
    //forever begin
      int count = 10;
      for (int i = 0; i < count; i++) begin
        req = seq_item::type_id::create("req");  //create the req (seq item)
        wait_for_grant();                            //wait for grant

        req.rdata = i;

        send_request(req);                           //send req to driver
        wait_for_item_done();                        //wait for item done from driver
      end
    //end
  endtask
endclass

`endif