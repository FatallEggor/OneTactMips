module datapath(
	input wire clk,
	input wire reset,
	
	input wire [31:0]	instr,	
	output wire [31:0]	pc_val,
	
	output wire [31:0]	mem_addr,
	output wire [31:0]	mem_write,
	input wire [31:0]	mem_read,

	output wire [5:0]	op_c,
	output wire [5:0]	funct,	
	output wire		zero,

	input wire		argB_c, dest_reg_c, we_c, ext_c, sh_d_c,
	input wire [1:0]	pc_next_c, result_c, 
	input wire [3:0]	alu_c, 
	
//	output wire [31:0] bus 
	output wire [7:0]	leds
	);
	
	wire [31:0]	A, B, rd2, C, s_imm, result; 
	wire [31:0]	pc_next, pc_inc, pc_br, shifted;
	wire [4:0]	dest_reg;

	PC		pc(.ctrl(clk), .reset(reset), .in(pc_next), .out(pc_val));


	adder		pc_incr(.A(32'h00000001), .B(pc_val), .C(pc_inc));

	adder		branch_add(.A(s_imm), .B(pc_inc), .C(pc_br));

	pc_val_mux	pc_mux(.ctrl(pc_next_c), .in0(pc_inc), .in1(pc_br), .in2({pc_val[31:26], instr[25:0]}), .out(pc_next));

	sign_ext	s_e_imm(.ext_c(ext_c), .in(instr[15:0]), .out(s_imm));

	reg_file 	r_f(.clk(clk),.we(we_c), .ra1(instr[25:21]), .ra2(instr[20:16]), .wa(dest_reg), .rd1(A), .rd2(rd2), .wd(result), .leds(leds));

	mux2to1		#(.SIZE(5))mux21_dest(.in0(instr[15:11]), .in1(instr[20:16]), .ctrl(dest_reg_c), .out(dest_reg));
	
	mux2to1		mux21_argB(.in0(rd2), .in1(s_imm), .ctrl(argB_c), .out(B));
	
	alu 		alu_uut(.A(A), .B(B), .C(C), .mode(alu_c), .zero(zero));

	shifter		shift(.sh_d_c(sh_d_c), .shamt(instr[10:6]), .in(rd2), .out(shifted));
	
	mux3to1		mux31_result(.in0(C), .in1(mem_read), .in2(shifted), .ctrl(result_c), .out(result));
	
	
	assign mem_addr = C;
	assign mem_write = rd2;

	assign op_c = instr[31:26];
	assign funct = instr[5:0];

//	assign bus = instr /*pc_val result read_data*/ ;

endmodule
