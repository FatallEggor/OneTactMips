
module ram (
	input wire clk,
	input wire we,
	input wire [31:0] addr,
	input wire [31:0] d_in,
	output wire [31:0] d_out
	);

	reg [31:0] data [1024:0];
	
	initial
		begin
			data[0] = {32'h1fffffff};
			data[1] = {32'h10000002};
			data[2] = {32'h00000004};
			data[3] = {32'h00000002};
			data[4] = {32'h00000007};
			data[5] = {32'h00000007};
			data[6] = {32'h00000003};
			data[7] = {32'h00000003};
			data[8] = {32'h00000013};
			data[9] = {32'h00000003};
			data[10] = {32'h00000003};
			data[11] = {32'h00000003}; 
			data[12] = {32'h00000003};
			data[13] = {32'h00000003};
			data[14] = {32'h00000003};
			data[15] = {32'h00000003};
			data[30] = {32'hfffffff3};
			data[31] = {32'heeeeeee3};
		end
		
	always @(negedge clk)
	begin
		if (we)
			data[addr[31:2]] <= d_in;
	end

	assign d_out = data[addr[31:2]];
endmodule
