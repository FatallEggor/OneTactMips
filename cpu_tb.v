`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:39:10 12/25/2016
// Design Name:   cpu
// Module Name:   /home/egor/Projects/verilog/contr_tests/final/mips1/cpu_tb.v
// Project Name:  mips1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

localparam T = 20;

	// Inputs
	reg clk;
	reg reset;
	/*reg argB_c;
	reg [3:0] alu_c;
	reg dest_reg_c;
	reg we_c;
	reg result_c;
	reg mw_c;
	reg branch_c;*/

	// Outputs
	wire led0;
	wire led1;
	wire led2;
	wire led3;
	wire led4;
	wire led5;
	wire led6;
	wire led7;
	wire [31:0] bus;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk), 
		.reset(reset), 
		/*.argB_c(argB_c), 
		.alu_c(alu_c), 
		.dest_reg_c(dest_reg_c), 
		.we_c(we_c), 
		.result_c(result_c), 
		.mw_c(mw_c), 
		.branch_c(branch_c), */
		.led0(led0), 
		.led1(led1), 
		.led2(led2), 
		.led3(led3), 
		.led4(led4), 
		.led5(led5), 
		.led6(led6), 
		.led7(led7), 
		.bus(bus)
	);

   always
	begin
      clk = 1'b1;
      #(T/2);
      clk = 1'b0;
      #(T/2);
   end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		/*argB_c = 0;
		alu_c = 0;
		dest_reg_c = 0;
		we_c = 0;
		result_c = 0;
		mw_c = 0;
		branch_c = 0;*/

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		reset = 0;
		/*argB_c = 0;
		alu_c = 4'b1000;
		dest_reg_c = 0;
		we_c = 1;
		result_c = 0;
		mw_c = 0;
		branch_c = 0;*/

	end
      
endmodule

