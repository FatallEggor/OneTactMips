module adder 
	#(parameter SIZE = 32)
	(
	input wire [SIZE-1:0]A,
	input wire [SIZE-1:0]B,

	output wire [SIZE-1:0]C
	);

	assign C = A + B;

endmodule
