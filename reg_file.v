`include "./include/registers.v"

module reg_file(
	input wire clk,
	input wire we,//for write enable

	input wire [4:0] ra1,//
	input wire [4:0] ra2,//for read  addresses
	input wire [4:0] wa,//for write address

	
	output wire [31:0] rd1,// for read data
	output wire [31:0] rd2,//
	input wire [31:0] wd,//for write data
	
	output wire [7:0] leds
);

	reg [31:0] rf [31:0];
	
	initial 
		begin
		$readmemh("reg_init.data", rf, 0, 31);
		end
		
	always @(posedge clk)
	if (we)
		rf[wa] <= wd;

	assign rd1 = (ra1 != 32'b0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 32'b0) ? rf[ra2] : 0;
	
	//assign leds = rf [`S0][7:0];

endmodule
