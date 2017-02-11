module pc_val_mux 
	#(parameter SIZE = 32)
	(
	input wire [1:0] ctrl,
	input wire [SIZE-1:0] in0,
	input wire [SIZE-1:0] in1,
	input wire [SIZE-1:0] in2,

	output reg [SIZE-1:0] out
	);

	always @*
		(*full_case*) case(ctrl)
			2'd0: out <= in0;
			2'd1: out <= in1;
			2'd2: out <= in2;
		endcase

endmodule
