`include "registers.v"

module reg_file(
	input wire clk,
	input wire we,//for write enable

	input wire [4:0] ra1,//
	input wire [4:0] ra2,//for read  addresses
	input wire [4:0] wa,//for write address

	
	output wire [31:0] rd1,// for read data
	output wire [31:0] rd2,//
	input wire [31:0] wd//for write data
);

	reg [31:0] rf [31:0];
	
/*	initial 
		begin
		rf[s1] = 32'h00000002;
		rf[s2] = 32'h00000001;//32'h43214321;
		rf[s3] = 32'h00000001;
		rf[s4] = 32'h00000000;
		rf[a1] = 32'h00000000;
		
		rf[gp] = 32'hffffffff;
		end*/
		
	always @(posedge clk)
	if (we)
		rf[wa] <= wd;

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
