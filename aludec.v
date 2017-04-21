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
	 subtr_f = 4'b1001;

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
				6'b100000: alu_c <= add_f;
				6'b100010: alu_c <= subtr_f;
				6'b100100: alu_c <= and_f;
				6'b100101: alu_c <= or_f;
				6'b100110: alu_c <= xor_f;
				6'b100111: alu_c <= nor_f;
				6'b101011: alu_c <= nand_f;
				6'b101010: alu_c <= slt_f;
				default:
					alu_c <= 4'bxxxx;
			endcase

			default:
				alu_c <= 4'bxxx;//add_f
		endcase
	endmodule	
