module shifter (
	input wire [1:0]	sh_c,
	input wire [4:0]	shamt,
	input wire [31:0]	in,

	output wire[31:0]	out
	);
	
	wire [31:0] ls0, rs0, ls1, rs1, ls2, rs2, ls3, rs3, slc, src; 
	
	assign rs0 = shamt[0] ? {in[0], in[31:1]} : in;
	assign ls0 = shamt[0] ? {in[30:0], in[31]} : in;

	assign rs1 = shamt[1] ? {rs0[1:0], rs0[31:2]} : rs0;
	assign ls1 = shamt[1] ? {ls0[29:0], ls0[31:30]} : ls0;

	assign rs2 = shamt[2] ? {rs1[3:0], rs1[31:4]} : rs1;
	assign ls2 = shamt[2] ? {ls1[27:0], ls1[31:28]} : ls1;

	assign rs3 = shamt[3] ? {rs2[7:0], rs2[31:8]} : rs2;
	assign ls3 = shamt[3] ? {ls2[23:0], ls2[31:24]} : ls2;

	assign src = shamt[4] ? {rs3[15:0], rs3[31:16]} : rs3;
	assign slc = shamt[4] ? {ls3[15:0], ls3[31:16]} : ls3;

	assign out = sh_c[1] ? (sh_c[0]? slc : src) : (sh_c[0]? (in << shamt) : (in >> shamt));

endmodule
