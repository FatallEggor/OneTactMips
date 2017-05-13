module rk_gen 
(
	input wire [4:0]	raund,
	output wire [31:0]	raundkey
);
	reg [31:0] key [7:0];
	wire [2:0] keynum;

	initial
	begin
		key[0] = 32'hffeeddcc;//hffeeddcc
		key[1] = 32'hbbaa9988;//hbbaa9988
		key[2] = 32'h77665544;
		key[3] = 32'h33221100;
		key[4] = 32'hf0f1f2f3;
		key[5] = 32'hf4f5f6f7;
		key[6] = 32'hf8f9fafb;
		key[7] = 32'hfcfdfeff;
	end

	assign keynum = (raund[4:3] == 2'b11)? ~raund[2:0] : raund[2:0];

	assign raundkey = key[keynum];

endmodule
