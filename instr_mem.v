`include "registers.v"
`include "funct_codes.v"

module instr_mem (
	input wire [31:0] addr,
	output reg [31:0] data
	);

	always @(addr)
	begin
		case(addr)
			32'h00000000: data <= {`J_OP, 26'h0000004};
			32'h00000000: data <= {`ADDI_OP, `S3, `S2, 16'h00000001};
			32'h00000000: data <= {`RTYPE_OP, `S1, `S2, `S3, 5'b000000001, `ADD_F};
			32'h00000001: data <= {`BEQ_OP, `S1, `S2, 16'h0001 /*`S3, 5'b00001, XOR_F*/};
			32'h00000002: data <= {`J_OP, `S3, `S1, 16'h1111 /*`S3, 5'b00001, XOR_F*/};
			32'h00000003: data <= {`LW_OP, `S4, `A1, 16'h0003};
			32'h00000004: data <= {`RTYPE_OP, `S4, `A1, /*16'h0000*/`S0, 5'b11000, `SUBTR_F};
			
			32'h00000005: data <= {`SW_OP, `S4, `S0, 16'h0000};
			32'h00000006: data <= {`LW_OP, `S4, `A1, 16'h0000};
		
			default:  data <= {`LW_OP, `S4, `V0, 16'h0003 /*`S3, 5'b00001, XOR_F*/};

		endcase
	end

endmodule
