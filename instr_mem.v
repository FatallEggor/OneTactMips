
`define J_OP 6'b000010

module instr_mem (
	input wire [31:0] addr,
	output reg [31:0] data
	);

localparam 
	//op_codes
	Rtype_op = 6'b000000,
	lw_op = 6'b100011,
	sw_op = 6'b101011,
	beq_op = 6'b000100,
	addi_op = 6'b001000,
	and_op  = 6'b100100, 
	or_op = 6'b100101,
	xor_op = 6'b100110,
	nor_op = 6'b100111,
	slt_op = 6'b101010,
 
	j_op = 6'b000010,
	alti_op = 6'b001010,
	mult_op = 6'b011000,
	div_op = 6'b011010,

	//funct
	//logical
	and_f = 6'b100100,
	or_f = 6'b100101,
	xor_f = 6'b100110,
	nor_f = 6'b100111,
	slt_f = 6'b101010,
	nand_f = 6'b101011,

	//arithmetic
	add_f = 6'b100000,
	addu_f = 6'b100001,
	subtr_f = 6'b100010,
	

	//registers
	zero = 5'b00000,

	at = 5'b00001,

	v0 = 5'b00010,
	v1 = 5'b00011,

	a0 = 5'b00100,
	a1 = 5'b00101,
	a2 = 5'b00110,
	a3 = 5'b00111,

	t0 = 5'b01000,
	t1 = 5'b01001,
	t2 = 5'b01010,
	t3 = 5'b01011,
	t4 = 5'b01100,
	t5 = 5'b01101,
	t6 = 5'b01110,
	t7 = 5'b01111,

	s0 = 5'b10000,
	s1 = 5'b10001,
	s2 = 5'b10010,
	s3 = 5'b10011,
	s4 = 5'b10100,
	s5 = 5'b10101,
	s6 = 5'b10110,
	s7 = 5'b10111,


	t8 = 5'b11000,
	t9 = 5'b11001,

	k0 = 5'b11010,
	k1 = 5'b11011,

	gp = 5'b11100,
	sp = 5'b11101,
	fp = 5'b11110,
	ra = 5'b11111;
	
	always @(addr)
	begin
		case(addr)
			32'h00000000: data <= {`J_OP, 26'h0000004};
			//32'h00000000: data <= {addi_op, s3, s2, 16'h00000001};
			//32'h00000000: data <= {Rtype_op, s1, s2, s3, 5'b000000001, add_f};
			32'h00000001: data <= {beq_op, s1, s2, 16'h0001 /*s3, 5'b00001, xor_f*/};
			32'h00000002: data <= {j_op, s3, s1, 16'h1111 /*s3, 5'b00001, xor_f*/};
			32'h00000003: data <= {lw_op, s4, a1, 16'h0003};
			32'h00000004: data <= {Rtype_op, s4, a1, /*16'h0000*/s0, 5'b11000, subtr_f};
			
			32'h00000005: data <= {sw_op, s4, s0, 16'h0000};
			32'h00000006: data <= {lw_op, s4, a1, 16'h0000};
			
			default:  data <= {lw_op, s1, s2, 16'h0003 /*s3, 5'b00001, xor_f*/};

		endcase
	end

endmodule









