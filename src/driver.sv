`ifndef DRIVER_SV
`define DRIVER_SV

class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)

  // Virtual Interface
  virtual data_if m_data_if;
  virtual clk_rst_if clrst_if;
    
  //uvm_analysis_port #(seq_item) Drvr2Sb_port;

  // Constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      if(!uvm_config_db #(virtual clk_rst_if)::get(this,"", "clrst_if", clrst_if))
        `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase

  // run phase
  virtual task run_phase(uvm_phase phase);
    seq_item tx;
    forever begin
    seq_item_port.get_next_item(tx);
    //respond_to_transfer(req);
    drive(tx);
    seq_item_port.item_done();
    end
  endtask : run_phase

  // drive 
  virtual task drive(seq_item tx);
    //req.print();
    //repeat(1) @(posedge clrst_if.clk);
    @(posedge clrst_if.clk);
    $display($sformatf("hey: %s, data: %d \n", get_full_name(), tx.rdata));
    m_data_if.data <= tx.rdata;
    //`uvm_fatal(get_full_name(), "Finish exec");
  endtask : drive

endclass : driver

`endif