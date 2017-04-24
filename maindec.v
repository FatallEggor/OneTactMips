`include "./include/funct_codes.v"

module maindec
	(
	input wire [5:0]	op_c,
	input wire [5:0]	funct,
		
	output wire		argB_c,
	output wire [1:0]	dest_reg_c,
	output wire		we_c,
	output wire		beq,
	output wire		bne,
	output wire		j_c,
	output wire		jr_c,
	output wire		ext_c,
	output wire		wd_c,
	output wire		sh_d_c,
	output wire [1:0]	result_c,
	output wire [2:0]	aluop
	);
	
	reg [12:0] 	op_c_s;
	reg [2:0] 	f_c_s;
	reg 		we;
	wire 		result0, result1;

	assign {we_c, argB_c, dest_reg_c, result0_c, beq, bne, j_c, ext_c, wd_c, aluop} =  op_c_s;

	always @(op_c or funct)
	begin
		case (op_c)
			`RTYPE_OP: 
			begin
				if (funct == `JR_F)
					we = 1'b0;
				else
					we = 1'b1;

				op_c_s <=	{we, 13'b0_00_0_0_0_0_0_0_111}; 			
			end
			`LW_OP: op_c_s <=	13'b1_1_01_1_0_0_0_0_0_000; 
			`SW_OP: op_c_s <=	13'b0_1_00_0_0_0_0_0_0_000; 
			
			`JAL_OP: op_c_s <=	13'b1_0_10_0_0_0_1_0_1_000; 
			`J_OP: op_c_s <=	13'b0_0_00_0_0_0_1_0_0_000; 
			`BEQ_OP: op_c_s <=	13'b0_0_00_0_1_0_0_0_0_001; 
			`BNE_OP: op_c_s <=	13'b0_0_00_0_0_1_0_0_0_001; 
			
			`ADDI_OP: op_c_s <=	13'b1_1_01_0_0_0_0_0_0_000; 
			`LUI_OP: op_c_s <=	13'b1_1_01_0_0_0_0_1_0_000; 
			`ORI_OP: op_c_s <=	13'b1_1_01_0_0_0_0_0_0_010; 
			`SLTI_OP: op_c_s <=	13'b1_1_01_0_0_0_0_0_0_011; 
			`ANDI_OP: op_c_s <=	13'b1_1_01_0_0_0_0_0_0_100; 
			default: 
				begin
					op_c_s <=	13'b0_0_00_0_0_0_0_0_0_000; //NOTHING
				end
		endcase

		case ({op_c, funct}) 
			{`RTYPE_OP, `SLL_F}: 
				f_c_s <=	3'b110;
			{`RTYPE_OP, `SRL_F}:
				f_c_s <=	3'b100;
			{`RTYPE_OP, `JR_F}: 
				f_c_s <=	3'b001;
			default:
				f_c_s <=	3'b000;
		endcase
			

	end


				
	assign {result1_c, sh_d_c, jr_c} = f_c_s;
	assign result_c = {result1_c, result0_c};

endmodule
