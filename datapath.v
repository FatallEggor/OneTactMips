`include "./include/registers.v"

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

	input wire		argB_c, we_c, ext_c, sh_d_c, wd_c,
	input wire [1:0]	dest_reg_c, result_c,
	input wire [2:0]	pc_next_c,
	input wire [3:0]	us, alu_c, 
	
	output wire [31:0]	bus, 
	output wire [7:0]	leds
	);
	
	wire [31:0]	A, B, rd2, C, s_imm, result, wd; 
	wire [31:0]	pc_next, pc_inc, pc_br, shifted, s_imm_sll2;
	wire [4:0]	dest_reg;

	PC		pc(.ctrl(clk), .reset(reset), .in(pc_next), .out(pc_val));


	adder		pc_incr(.A(32'h00000004), .B(pc_val), .C(pc_inc));

	sll2		sll2_imm(.in(s_imm), .out(s_imm_sll2));

	adder		branch_add(.A(s_imm_sll2), .B(pc_inc), .C(pc_br));

	pc_val_mux	pc_mux(.ctrl(pc_next_c), .in0(pc_inc), .in1(pc_br), .in2({pc_val[31:28], instr[25:0], 2'b00}), .in3(A), .out(pc_next));

	sign_ext	s_e_imm(.ext_c(ext_c), .in(instr[15:0]), .out(s_imm));

	reg_file 	r_f(.clk(clk),.we(we_c), .ra1(instr[25:21]), .ra2(instr[20:16]), .wa(dest_reg), .us(us), .rd1(A), .rd2(rd2), .wd(wd), .leds(leds));

	mux3to1		#(.SIZE(5))mux31_dest(.in0(instr[15:11]), .in1(instr[20:16]), .in2(`RA), .ctrl(dest_reg_c), .out(dest_reg));
	
	mux2to1		mux21_argB(.in0(rd2), .in1(s_imm), .ctrl(argB_c), .out(B));
	
	alu 		alu_uut(.A(A), .B(B), .C(C), .mode(alu_c), .zero(zero));

	shifter		shift(.sh_d_c(sh_d_c), .shamt(instr[10:6]), .in(rd2), .out(shifted));
	
	mux3to1		mux31_result(.in0(C), .in1(mem_read), .in2(shifted), .ctrl(result_c), .out(result));
	
	mux2to1		mux21_wd(.in0(result), .in1(pc_inc), .ctrl(wd_c), .out(wd));
	
	
	assign mem_addr = C;
	assign mem_write = rd2;

	assign op_c = instr[31:26];
	assign funct = instr[5:0];

	assign bus = instr /*pc_val result read_data*/ ;

endmodule
