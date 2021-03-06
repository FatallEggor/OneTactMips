`include "./include/funct_codes.v"

module maindec
	(
	input wire [5:0]	op_c,
	input wire [5:0]	funct,
		
	output wire		argA_c,
	output wire		argB_c,
	output wire [1:0]	dest_reg_c,
	output wire		we_c,
	output wire		beq,
	output wire		bne,
	output wire		j_c,
	output wire		jr_c,
	output wire [1:0]	ext_c,
	output wire		wd_c,
	output wire [1:0]	sh_c,
	output wire [2:0]	result_c,
	output wire [2:0]	aluop
	);
	
	reg [14:0] 	op_c_s;
	reg [4:0] 	f_c_s;
	reg 		we;
	wire 		result_f_c;
	wire [1:0]	result_op_c; 

	assign {we_c, argB_c, dest_reg_c, result_op_c, beq, bne, j_c, ext_c, wd_c, aluop} =  op_c_s;

	always @(op_c or funct)
	begin
		case (op_c)
			`RTYPE_OP: 
			begin
				if (funct == `JR_F)
					we = 1'b0;
				else
					we = 1'b1;

				op_c_s <=	{we, 14'b0_0_00_00_0_0_0_00_0_111}; 			
			end
			`LW_OP:	op_c_s <=	15'b1_1_01_01_0_0_0_00_0_000; 
			`SW_OP: op_c_s <=	15'b0_1_00_00_0_0_0_00_0_000; 
			
			`JAL_OP: op_c_s <=	15'b1_0_10_00_0_0_1_00_1_000; 
			`J_OP: op_c_s <=	15'b0_0_00_00_0_0_1_00_0_000; 
			`BEQ_OP: op_c_s <=	15'b0_0_00_00_1_0_0_00_0_001; 
			`BNE_OP: op_c_s <=	15'b0_0_00_00_0_1_0_00_0_001; 
			
			`ADDI_OP: op_c_s <=	15'b1_1_01_00_0_0_0_00_0_000; 
			`LUI_OP: op_c_s <=	15'b1_1_01_00_0_0_0_01_0_000; 
			`ORI_OP: op_c_s <=	15'b1_1_01_00_0_0_0_10_0_010; 
			`SLTI_OP: op_c_s <=	15'b1_1_01_00_0_0_0_00_0_011; 
			`ANDI_OP: op_c_s <=	15'b1_1_01_00_0_0_0_10_0_100;

			`CSUB_OP: op_c_s <=	15'b1_1_01_10_0_0_0_00_0_000;

			default: 
				begin
					op_c_s <=	15'b0_0_00_0_0_0_0_0_0_000; //NOTHING
				end
		endcase

		case ({op_c, funct}) 
			{`RTYPE_OP, `SLL_F}: 
				f_c_s <=	5'b0_1_01_0;
			{`RTYPE_OP, `SRL_F}:
				f_c_s <=	5'b0_1_00_0;
			{`RTYPE_OP, `SLC_F}: 
				f_c_s <=	5'b0_1_11_0;
			{`RTYPE_OP, `SRC_F}:
				f_c_s <=	5'b0_1_10_0;
			{`RTYPE_OP, `JR_F}: 
				f_c_s <=	5'b0_0_00_1;
			{`RTYPE_OP, `CKX_F}: 
				f_c_s <=	5'b1_0_00_0;
			default:
				f_c_s <=	5'b0_0_00_0;
		endcase
			

	end


				
	assign {argA_c, result_f_c, sh_c, jr_c} = f_c_s;
	assign result_c = {result_f_c, result_op_c};

endmodule
