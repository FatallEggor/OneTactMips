module sign_ext
	#(parameter SIZE = 16)
	(
	input wire [1:0]	ext_c,

	input wire [SIZE-1:0] 	in,
	output reg [31:0] 	out
	);
	
	always @*
		case(ext_c)
		2'b00:
			out = {{SIZE{in[SIZE-1]}}, in};
		2'b01:
			out = {in,{32-SIZE{1'b0}}};
		2'b10:
			out = {{32-SIZE{1'b0}}, in};
		default:
			out = 32'b0;
		
	endcase
endmodule
