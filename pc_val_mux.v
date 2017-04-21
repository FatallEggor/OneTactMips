module pc_val_mux 
	#(parameter SIZE = 32)
	(
	input wire [2:0] ctrl,
	input wire [SIZE-1:0] in0,
	input wire [SIZE-1:0] in1,
	input wire [SIZE-1:0] in2,
	input wire [SIZE-1:0] in3,

	output reg [SIZE-1:0] out
	);

	always @*
		 case(ctrl)
			3'b000: out <= in0;
			3'b001: out <= in1;
			3'b010: out <= in2;
			3'b100: out <= in3;
			default: out <= 3'b0;
		endcase

endmodule
