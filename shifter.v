module shifter (
	input wire		sh_d_c,
	input wire [4:0]	shamt,
	input wire [31:0]	in,

	output wire[31:0]	out
	);
	
	assign out = (sh_d_c) ? (in << shamt) : (in >> shamt);

endmodule
