`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Project Name: CPU
// Additional Comments: just a simple ALU without any optimisation.
//
//////////////////////////////////////////////////////////////////////////////////
module alu(
	input wire [3:0]	mode,
	input wire [31:0]	A,
	input wire [31:0]	B,
	output reg [31:0]	C,
	output reg		zero
    );
	 
localparam //functions
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
	 cxk_f = 4'b1100;
	 
	 
	 
	 always @ *
	 begin
	 zero = 0;
		case(mode)
		and_f:
			C = A & B;
			
		nand_f:
			C = ~(A & B);
			
		or_f:
			C = A | B;	
			
		xor_f:
			C = A ^ B;

		cxk_f:
			C = A + B;
			
		nor_f:
			C = ~(A | B);

		slt_f:
			C = (A < B) ? 32'h00000001 : 32'h00000000;

		//arithmetic
		
		subtr_f:
			C = A - B;
			
		add_f:
			C = A + B;
			
		default:
			C = A;
			
		endcase
		
		if (C == 0)
				zero = 1'b1;
	 end


endmodule
