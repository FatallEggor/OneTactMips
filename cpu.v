module cpu(
	input wire	clk,
	input wire	reset,

	output wire	led0,
	output wire	led1,
	output wire	led2,
	output wire	led3,
	output wire	led4,
	output wire	led5,
	output wire	led6,
	output wire	led7,

	output wire	bus0,
	output wire	bus1,
	output wire	bus2,
	output wire	bus3,
	output wire	bus4,
	output wire	bus5,
	output wire	bus6,
	output wire	bus7,
	output wire	bus8,
	output wire	bus9,
	output wire	bus10,
	output wire	bus11,
	output wire	bus12,
	output wire	bus13,
	output wire	bus14,
	output wire	bus15,
	output wire	bus16,
	output wire	bus17,
	output wire	bus18,
	output wire	bus19,
	output wire	bus20,
	output wire	bus21,
	output wire	bus22,
	output wire	bus23,
	output wire	bus24,
	output wire	bus25,
	output wire	bus26,
	output wire	bus27,
	output wire	bus28,
	output wire	bus29,
	output wire	bus30,
	output wire	bus31

	);

	wire [31:0]	instr, pc_val, mem_addr, mem_write, mem_read;
	wire [5:0]	op_c, funct;
	wire		zero, argB_c, dest_reg_c, we_c, mw_c, ext_c;
	wire [1:0]	result_c, pc_next_c; 
	wire [3:0]	alu_c; 
	wire [7:0]	leds;
	wire [31:0]	bus;

	datapath	datapath_u ( .clk(clk), .reset(reset), .instr(instr), .pc_val(pc_val), .mem_addr(mem_addr), .mem_write(mem_write), .mem_read(mem_read), .op_c(op_c), .funct(funct), .zero(zero), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .result_c(result_c), .we_c(we_c), .ext_c(ext_c), .sh_d_c(sh_d_c), .pc_next_c(pc_next_c), .alu_c(alu_c), .leds(leds) , .bus(bus));

	contr		contr_u ( .op_c(op_c), .funct(funct), .zero(zero), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .result_c(result_c),.we_c(we_c), .mw_c(mw_c), .ext_c(ext_c), .sh_d_c(sh_d_c), .pc_next_c(pc_next_c), .alu_c(alu_c));

	ram		data_mem (.clk(clk), .we(mw_c), .addr(mem_addr), .d_in(mem_write), .d_out(mem_read)/*, .leds(leds)*/);
	instr_mem	instr_mem (.addr(pc_val), .data(instr));
	
	assign {led0, led1, led2, led3, led4, led5, led6, led7} = leds; 
	assign {bus0, bus1, bus2, bus3, bus4, bus5, bus6, bus7, bus8, bus9, bus10, bus11, bus12, bus13, bus14, bus15, bus16, bus17, bus18, bus19, bus20, bus21, bus22, bus23, bus24, bus25, bus26, bus27, bus28, bus29, bus30, bus31} = bus;
endmodule
