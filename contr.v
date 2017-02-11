//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Design Name: 
// Module Name:    reg1 
// Project Name: 
// Description: Control signals consist of 2 categories: registers control(c_2) and oter contro; signals(c_s1)
//////////////////////////////////////////////////////////////////////////////////
module contr(
	input wire [5:0] op_c, 
	input wire [5:0] funct,
	input wire zero,

	output wire argB_c,
	output wire dest_reg_c,
	output wire result_c,
	output wire we_c,
	output wire mw_c,
	output wire [1:0]pc_next_c,
	output wire [3:0] alu_c

	);
	
	wire [1:0] aluop;
	
	maindec	main_dec(.op_c(op_c), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .we_c(we_c), .result_c(result_c), .mw_c(mw_c), .branch(branch), .j_c(j_c), .aluop(aluop));

	aludec	alu_dec(.funct(funct), .aluop(aluop), .alu_c(alu_c) );
	
	assign branch_c = zero & branch;
	assign pc_next_c = {j_c, branch_c};
	
endmodule
