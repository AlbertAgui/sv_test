module dut_top (
	input logic clk,    // Clock
	input logic rst_n,  // Asynchronous reset active low

	input logic [7:0] a_i,
	input logic [7:0] b_i 
);

logic [7:0] a;
logic [7:0] b;

always_ff @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		 a <= '0;
		 b <= '0;
	end else begin
		 a <= a_i;
		 b <= b_i;
		 $display("a_i: %d, b_i: %d \n", a_i, b_i);
	end
end


endmodule : dut_top
