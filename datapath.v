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

	input wire		argA_c, argB_c, we_c, wd_c,
	input wire [1:0]	dest_reg_c, ext_c, sh_c,
	input wire [2:0]	pc_next_c, result_c,
	input wire [3:0]	us, alu_c, 

	input wire		tmr_overflow,
	input wire [15:0]	tmr_cntr,
	output wire [31:0]	tmr_ctrl,
	
	output wire [31:0]	bus, 
	output wire [7:0]	leds
	);
	
	wire [31:0]	rt, rs, A, B, C, r_key, s_imm, result, wd; 
	wire [31:0]	pc_next, pc_inc, pc_br, shifted, sub, s_imm_sll2;
	wire [4:0]	dest_reg;

//PC and his next state evaluation;

	PC		pc(.ctrl(clk), .reset(reset), .in(pc_next), .out(pc_val));

	adder		pc_incr(.A(32'h00000004), .B(pc_val), .C(pc_inc));

	sll2		sll2_imm(.in(s_imm), .out(s_imm_sll2));

	adder		branch_add(.A(s_imm_sll2), .B(pc_inc), .C(pc_br));

	pc_val_mux	pc_mux(.ctrl(pc_next_c), .in0(pc_inc), .in1(pc_br), .in2({pc_val[31:28], instr[25:0], 2'b00}), .in3(rs), .out(pc_next));

//Data evaluation

	reg_file 	r_f(.clk(clk),.we(we_c), .ra1(instr[25:21]), .ra2(instr[20:16]), .wa(dest_reg), .rd1(rs), .rd2(rt), .wd(wd), .us(us), .tmr_cntr(tmr_cntr), .tmr_ctrl(tmr_ctrl), .leds(leds));

	mux3to1		#(.SIZE(5))mux31_dest(.in0(instr[15:11]), .in1(instr[20:16]), .in2(`RA), .ctrl(dest_reg_c), .out(dest_reg));

	sign_ext	s_e_imm(.ext_c(ext_c), .in(instr[15:0]), .out(s_imm));

//Instruction implementation
	
	mux2to1		mux21_argB(.in0(rt), .in1(s_imm), .ctrl(argB_c), .out(B));

	rk_gen		rk_gen_u(.raund(rs[4:0]), .raundkey(r_key));

	mux2to1		mux21_argA(.in0(rs), .in1(r_key), .ctrl(argA_c), .out(A));
	
	alu 		alu_u(.A(A), .B(B), .C(C), .mode(alu_c), .zero(zero));

	shifter		shift(.sh_c(sh_c), .shamt(instr[10:6]), .in(rt), .out(shifted));

	subst		subs(.in(rs), .out(sub));

//Result choose
	
	mux4to1		mux41_result(.in0(C), .in1(mem_read), .in4(shifted), .in2(sub), .ctrl(result_c), .out(result));
	
	mux2to1		mux21_wd(.in0(result), .in1(pc_inc), .ctrl(wd_c), .out(wd));
	
	
	assign mem_addr = C;
	assign mem_write = rt;

	assign op_c = instr[31:26];
	assign funct = instr[5:0];

	assign bus = sub /*pc_val result read_data*/ ;

endmodule
