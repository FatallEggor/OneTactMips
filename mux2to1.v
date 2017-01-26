module mux2to1 
	#(parameter SIZE = 32)
	(
	input wire [SIZE-1:0] in0,
	input wire [SIZE-1:0] in1,
	input wire ctrl,

	output wire [SIZE-1:0] out
	);

	assign out = ctrl ? in1 : in0;

endmodule
