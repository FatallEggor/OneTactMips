module cpu
(
	input wire	clk_in,
	input wire	reset,

	input wire	rx_m,
	output wire	tx_m,
	input wire	rx_fem,
	output wire	tx_fem,

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

	wire [31:0]	instr, pc_val, mem_addr, mem_write, mem_read, ram_out;
	wire [5:0]	op_c, funct;
	wire		zero, argB_c, we_c, wd_c, io_ram_c, io_uart_fem_c, io_uart_m_c, clk;
	wire [1:0]	dest_reg_c, result_c, ext_c, io_read_c;
	wire [2:0]	pc_next_c;
	wire [3:0]	us, alu_c; 
	wire [7:0]	leds, uart_fem_r, uart_m_r;
	wire [31:0]	bus, tmr_ctrl;
	wire		counter, tmr_overflow; 
	wire [15:0]	tmr_cntr;

	reg 		counter_reg = 1'b1;

	always @ (posedge clk_in)
		counter_reg <= counter;
	
	assign counter = counter_reg + 1'b1;
	assign clk = counter;

	contr		contr_u ( .op_c(op_c), .funct(funct), .zero(zero), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .result_c(result_c),.we_c(we_c), .ext_c(ext_c), .wd_c(wd_c), .sh_d_c(sh_d_c), .pc_next_c(pc_next_c), .alu_c(alu_c));

	datapath	datapath_u ( .clk(clk), .reset(reset), .instr(instr), .pc_val(pc_val), .mem_addr(mem_addr), .mem_write(mem_write), .mem_read(mem_read), .op_c(op_c), .funct(funct), .zero(zero), .argB_c(argB_c), .dest_reg_c(dest_reg_c), .result_c(result_c), .we_c(we_c), .ext_c(ext_c),.wd_c(wd_c),  .sh_d_c(sh_d_c), .pc_next_c(pc_next_c), .alu_c(alu_c), .us(us), .tmr_ctrl(tmr_ctrl), .tmr_cntr(tmr_cntr), .tmr_overflow(tmr_overflow), .leds(leds), .bus(bus));

	instr_mem	instr_mem (.addr(pc_val[10:0]), .data(instr));

	timer		tmr (.clk(clk), .reset(~tmr_ctrl[31]), .scale(tmr_ctrl[30:16]), .period(tmr_ctrl[15:0]), .cntr(tmr_cntr), .overflow(tmr_overflow));

	io_contr	io_c (.addr(mem_addr), .op_c(op_c), .io_ram_c(io_ram_c), .io_uart_fem_c(io_uart_fem_c), .io_uart_m_c(io_uart_m_c), .io_read_c(io_read_c));

	ram		data_mem (.clk(clk), .we(io_ram_c), .addr(mem_addr[11:0]), .d_in(mem_write), .d_out(ram_out)/*, .leds(leds)*/);

	uart		uart_fem (.clk(clk), .reset(reset), .rd_uart(io_read_c[0]), .wr_uart(io_uart_fem_c), .rx(rx_fem), .w_data(mem_write[7:0]), .tx_full(us[1]), .rx_empty(us[0]), .tx(tx_fem), .r_data(uart_fem_r));

	uart		uart_m (.clk(clk), .reset(reset), .rd_uart(io_read_c[1]), .wr_uart(io_uart_m_c), .rx(rx_m), .w_data(mem_write[7:0]), .tx_full(us[3]), .rx_empty(us[2]), .tx(tx_m), .r_data(uart_m_r));

	mux3to1		mux_io_read (.in0(ram_out), .in1({24'b0, uart_fem_r}), .in2({24'b0, uart_m_r}), .ctrl(io_read_c), .out(mem_read));
	
	assign {led0, led1, led2, led3, led4, led5, led6, led7} = leds; 
	assign {bus0, bus1, bus2, bus3, bus4, bus5, bus6, bus7, bus8, bus9, bus10, bus11, bus12, bus13, bus14, bus15, bus16, bus17, bus18, bus19, bus20, bus21, bus22, bus23, bus24, bus25, bus26, bus27, bus28, bus29, bus30, bus31} = bus;

endmodule
