`include "./include/funct_codes.v"

module maindec
	(
	input wire [5:0]	op_c,
	input wire [5:0]	funct,
		
	output wire		argB_c,
	output wire		dest_reg_c,
	output wire		we_c,
	output wire		mw_c,
	output wire		beq,
	output wire		bne,
	output wire		j_c,
	output wire		ext_c,
	output wire		sh_d_c,
	output wire[1:0]	result_c,
	output wire[2:0]	aluop
	);
	
	reg [11:0] op_c_s;
	reg [1:0] f_c_s;

	assign {argB_c, dest_reg_c, we_c, result0_c, mw_c, beq, bne, j_c, ext_c, aluop} =  op_c_s;

	always @(op_c or funct)
	begin
		case (op_c)
			`RTYPE_OP: op_c_s <= 12'b001000000_111; 
			
			`LW_OP: op_c_s <= 12'b111100000_000; 
			`SW_OP: op_c_s <= 12'b100010000_000; 
			
			`J_OP: op_c_s <= 12'b000000010_000; 
			`BEQ_OP: op_c_s <= 12'b000001000_001; 
			`BNE_OP: op_c_s <= 12'b000000100_001; 
			
			`ADDI_OP: op_c_s <= 12'b111000000_000; 
			`LUI_OP: op_c_s <= 12'b111000001_000; 
			`ORI_OP: op_c_s <= 12'b111000000_010; 
			`SLTI_OP: op_c_s <= 12'b111000000_011; 
			`ANDI_OP: op_c_s <= 12'b111000000_100; 
			default: op_c_s <= 12'b0000000000_000; //NOTHING
		endcase

		case ({op_c, funct})
			{`RTYPE_OP,`SLL_F}: f_c_s <= 2'b11;
			{`RTYPE_OP,`SRL_F}: f_c_s <= 2'b10;
			default: f_c_s <= 2'b00;
		endcase
	end	
				
	assign {result1_c, sh_d_c} = f_c_s;
	assign result_c = {result1_c, result0_c};

endmodule
