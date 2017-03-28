`include "./include/funct_codes.v"

module maindec
	(
	input wire [5:0] op_c,
		
	output wire argB_c,
	output wire dest_reg_c,
	output wire we_c,
	output wire result_c,
	output wire mw_c,
	output wire branch,
	output wire j_c,
	output wire ext_c,
	output wire [1:0] aluop
	);
	
	reg [9:0] c_s;

	assign {argB_c, dest_reg_c, we_c, result_c, mw_c, branch, j_c, ext_c, aluop} =  c_s;
	always @(op_c)
		(*full_case*)case(op_c)
			`RTYPE_OP: c_s <= 10'b00100000_10; // RTYPE	
			
			`LW_OP: c_s <= 10'b11110000_00; // LW
			`SW_OP: c_s <= 10'b10001000_00; // SW
			
			`J_OP: c_s <= 10'b00000010_00; // J
			`BEQ_OP: c_s <= 10'b00000100_01; // BEQ
			
			`ADDI_OP: c_s <= 10'b11100000_00; // ADDI
			`LUI_OP: c_s <= 10'b11100001_00; // LUI 
			`ORI_OP: c_s <= 10'b11100000_10; // ORI 
		endcase 
endmodule
