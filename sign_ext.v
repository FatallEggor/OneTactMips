module sign_ext
	#(parameter SIZE = 16)
	(
	input wire ext_c,

	input wire [SIZE-1:0] in,
	output reg [31:0] out
	);
	
	always @*
		case(ext_c)
		1'b0:
			out = {{SIZE{in[SIZE-1]}}, in};
		1'b1:
			out = {in,{32-SIZE{1'b0}}};
	endcase
endmodule
