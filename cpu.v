module cpu(
	input wire clk,
	input wire reset,

	output wire bus
	);

	wire [31:0] instr, pc_val, mem_addr, mem_write, mem_read;
	wire [5:0] op_c, funct;
	wire zero, argB_c, dest_reg_c, result_c, we_c, mw_c;
	wire [1:0] pc_next_c; 
	wire [3:0] alu_c; 

	datapath	datapath_u ( .clk(clk), .reset(reset), .instr(instr), .pc_val(pc_val), .mem_addr(mem_addr), .mem_write(mem_write), .mem_read(mem_read), .op_c(op_c), .funct(funct), .zero(zero), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .result_c(result_c), .we_c(we_c), .pc_next_c(pc_next_c), .alu_c(alu_c), .bus(bus));

	contr		contr_u ( .op_c(op_c), .funct(funct), .zero(zero), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .result_c(result_c),.we_c(we_c), .mw_c(mw_c), .pc_next_c(pc_next_c), .alu_c(alu_c));
	ram		data_mem (.clk(clk), .we(mw_c), .addr(mem_addr), .d_in(mem_write), .d_out(mem_read));
	instr_mem	instr_mem (.addr(pc_val), .data(instr));
endmodule
