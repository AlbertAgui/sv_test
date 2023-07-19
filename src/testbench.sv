module test_bench;
  logic                                     clk_i;
  logic                                     arstn_i;

  //init

  //clk
  initial begin 
    clk_i = 1'b0;
    forever clk_i = #10 ~clk_i;
  end 

  //test
  initial begin
    arstn_i = 1;
    repeat (1) @(posedge clk_i);
    arstn_i = 0;
    repeat (1) @(posedge clk_i);

endmodule

