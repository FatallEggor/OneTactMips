`include "./include/funct_codes.v"

module maindec
	(
	input wire [5:0]	op_c,
	input wire [5:0]	funct,
		
	output wire		argB_c,
	output wire		dest_reg_c,
	output wire		we_c,
	output wire		mw_c,
	output wire		branch,
	output wire		j_c,
	output wire		ext_c,
	output wire		sh_d_c,
	output wire[1:0]	result_c,
	output wire[1:0]	aluop
	);
	
	reg [9:0] op_c_s;
	reg [1:0] f_c_s;

	assign {argB_c, dest_reg_c, we_c, result0_c, mw_c, branch, j_c, ext_c, aluop} =  op_c_s;

	assign {result1_c, sh_d_c} = f_c_s;

	always @(op_c or funct)
	begin
		case (op_c)
			`RTYPE_OP: op_c_s <= 10'b00100000_10; // RTYPE	
			
			`LW_OP: op_c_s <= 10'b11110000_00; // LW
			`SW_OP: op_c_s <= 10'b10001000_00; // SW
			
			`J_OP: op_c_s <= 10'b00000010_00; // J
			`BEQ_OP: op_c_s <= 10'b00000100_01; // BEQ
			
			`ADDI_OP: op_c_s <= 10'b11100000_00; // ADDI
			`LUI_OP: op_c_s <= 10'b11100001_00; // LUI 
			`ORI_OP: op_c_s <= 10'b11100000_10; // ORI
			default: op_c_s <= 10'b00000000000; //NOTHING
		endcase

		case (funct)
			`SLL_F: f_c_s <= 2'b11;
			`SRL_F: f_c_s <= 2'b10;
			default: f_c_s <=2'b00;
		endcase
	end	
				
	assign result_c = {result1_c, result0_c};

endmodule
