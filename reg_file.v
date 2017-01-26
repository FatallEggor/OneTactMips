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

localparam 
//registers
	zero = 5'b00000,

	at = 5'b00001,

	v0 = 5'b00010,
	v1 = 5'b00011,

	a0 = 5'b00100,
	a1 = 5'b00101,
	a2 = 5'b00110,
	a3 = 5'b00111,

	t0 = 5'b01000,
	t1 = 5'b01001,
	t2 = 5'b01010,
	t3 = 5'b01011,
	t4 = 5'b01100,
	t5 = 5'b01101,
	t6 = 5'b01110,
	t7 = 5'b01111,

	s0 = 5'b10000,
	s1 = 5'b10001,
	s2 = 5'b10010,
	s3 = 5'b10011,
	s4 = 5'b10100,
	s5 = 5'b10101,
	s6 = 5'b10110,
	s7 = 5'b10111,


	t8 = 5'b11000,
	t9 = 5'b11001,

	k0 = 5'b11010,
	k1 = 5'b11011,

	gp = 5'b11100,
	sp = 5'b11101,
	fp = 5'b11110,
	ra = 5'b11111;

	reg [31:0] rf [31:0];
	
	initial 
		begin
		rf[s1] = 32'h00000002;
		rf[s2] = 32'h00000001;//32'h43214321;
		rf[s3] = 32'h00000001;
		rf[s4] = 32'h00000000;
		rf[a1] = 32'h00000000;
		
		rf[gp] = 32'hffffffff;
		end
		
	always @(posedge clk)
	if (we)
		rf[wa] <= wd;

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
