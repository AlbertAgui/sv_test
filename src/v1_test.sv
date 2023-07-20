`ifndef V1_TEST_SV
`define V1_TEST_SV

class v1_test extends uvm_test;
  `uvm_component_utils(v1_test)

  env m_env;
  seq m_seq;

  function new(string name = "v1_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_env = env::type_id::create("m_env", this);
    m_seq = seq::type_id::create("m_seq");
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    m_seq.start(m_env.agenta.m_sequencer);
  endtask : run_phase

endclass : v1_test

`endif