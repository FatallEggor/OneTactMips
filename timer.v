module timer 
(
	input wire 		clk,
	input wire 		reset,
	input wire [14:0]	scale,
	input wire [15:0]	period,

	output reg [15:0]	cntr,
	output reg		overflow
);
	reg [15:0]	cntr_next;
	reg [14:0]	scale_cntr, scale_cntr_next;

	always @(posedge reset, posedge clk)
	begin
		if (reset)
		begin
			cntr <= 16'b0;
			scale_cntr <= 15'b0;
		end
		else
		begin
			cntr <= cntr_next;
			scale_cntr <= scale_cntr_next;
		end
	end

	always @*
	begin
		scale_cntr_next = scale_cntr + 15'b1;
		cntr_next = cntr;

		if (scale_cntr >= scale)
		begin
			cntr_next = cntr + 16'b1;
			scale_cntr_next = 15'b0;
		end

		if (cntr >= period)
		begin
			cntr_next = 16'b0;
			overflow = 1'b1;
		end
	end
endmodule
