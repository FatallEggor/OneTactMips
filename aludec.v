`include "include/funct_codes.v"

module aludec (
	input wire [5:0] funct,
	input wire [2:0] aluop,

	output reg [3:0] alu_c
	);
	
localparam
	 //logical
	 and_f = 4'b0000,
	 or_f = 4'b0001,
	 xor_f = 4'b0010,
	 nor_f = 4'b0011,
	 slt_f = 4'b0100,
	 nand_f = 4'b0101,
	 
	 //arithmetic
	 add_f = 4'b1000,
	 subtr_f = 4'b1001,

	 //cipher
	 cka_f = 4'b1100;

	always @*
		case (aluop)
			3'b000: alu_c <= add_f; 
			3'b001: alu_c <= subtr_f;
			3'b010: alu_c <= or_f;
			3'b011: alu_c <= slt_f;
			3'b100: alu_c <= and_f;


			3'b111:
			case(funct)
				// R-type instructions
				`ADD_F: alu_c <= add_f;
				`SUBTR_F: alu_c <= subtr_f;
				`AND_F: alu_c <= and_f;
				`OR_F: alu_c <= or_f;
				`XOR_F: alu_c <= xor_f;
				`NOR_F: alu_c <= nor_f;
				`NAND_F: alu_c <= nand_f;
				`SLT_F: alu_c <= slt_f;
				`CKX_F: alu_c <= cka_f;
				default:
					alu_c <= 4'bxxxx;
			endcase

			default:
				alu_c <= 4'bxxx;//add_f
		endcase
	endmodule	
