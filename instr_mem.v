`include "./include/registers.v"
`include "./include/funct_codes.v"

module instr_mem (
	input wire [10:0] addr,
	output wire [31:0] data
	);
	
	reg [31:0] mem [511:0];

	initial
		begin
		$readmemh("instr.data", mem, 0, 31);
		end

	assign data = mem[addr[10:2]];

endmodule
