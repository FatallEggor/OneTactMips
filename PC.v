`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////
module PC
#(parameter
	SIZE = 32	
)
(
	input wire ctrl,
	input wire reset,
	input wire [SIZE-1:0] in,

	output reg [SIZE-1:0] out
   );
	
	initial
		out = 0;
		
	always @(posedge ctrl, posedge reset)
	begin
		if (reset)
			out <= 0;
		else
			out <= in;
	end

endmodule
