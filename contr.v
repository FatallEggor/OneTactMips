//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:	FatallEggor 
// Design Name: 
// Module Name:	reg1 
// Project Name: 
// Description: Control signals consist of 2 categories: registers control(c_2) and oter contro; signals(c_s1)
//////////////////////////////////////////////////////////////////////////////////
`include "./include/funct_codes.v"
module contr(
	input wire		zero,
	input wire [5:0]	op_c, 
	input wire [5:0]	funct,

	output wire		argB_c,
	output wire [1:0]	dest_reg_c,
	output wire		we_c,
	output wire [1:0]	ext_c,
	output wire		wd_c,
	output wire		sh_d_c,
	output wire [2:0]	pc_next_c,
	output wire [1:0]	result_c,
	output wire [3:0]	alu_c

	);
	
	wire [2:0] 	aluop;
	wire 		jr_c;
	
	maindec	main_dec(.funct(funct), .op_c(op_c), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .we_c(we_c), .result_c(result_c), .beq(beq), .bne(bne), .j_c(j_c), .jr_c(jr_c), .ext_c(ext_c), .wd_c(wd_c), .sh_d_c(sh_d_c), .aluop(aluop));

	aludec	alu_dec(.funct(funct), .aluop(aluop), .alu_c(alu_c) );
	
	assign branch_c =(~zero & bne) | (zero & beq);
	assign pc_next_c = {jr_c, j_c, branch_c};

	
endmodule
