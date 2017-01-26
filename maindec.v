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
	output wire [1:0] aluop
	);
	
	reg [7:0] c_s;

	assign {argB_c, dest_reg_c, we_c, result_c, mw_c, branch, j_c, aluop} =  c_s;
	always @(op_c)
		(*full_case*)case(op_c)
			6'b000000: c_s <= 8'b0010000_10; // RTYPE
			6'b100011: c_s <= 8'b1111000_00; // LW
			6'b101011: c_s <= 8'b1000100_00; // SW
			6'b000100: c_s <= 8'b0000010_01; // BEQ
			6'b001000: c_s <= 8'b1110000_00; // ADDI
			6'b000010: c_s <= 8'b0000001_00; // J
	endcase
endmodule
