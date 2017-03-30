module mux3to1 
	#(parameter SIZE = 32)
	(
	input wire [SIZE-1:0]	in0,
	input wire [SIZE-1:0]	in1,
	input wire [SIZE-1:0]	in2,
	input wire [1:0]	ctrl,

	output reg [SIZE-1:0] out
	);

	always @*
	begin
		case (ctrl)
			2'b00:
				out = in0;
			2'b01:
				out = in1;
			2'b10:
				out = in2;
			default:
				out = 32'b0;
		endcase
	end
endmodule
