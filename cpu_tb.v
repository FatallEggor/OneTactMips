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

	// Outputs
	wire [31:0] bus;
	wire led0;
	wire led1;
	wire led2;
	wire led3;
	wire led4;
	wire led5;
	wire led6;
	wire led7;



	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk_in(clk), 
		.reset(reset),
		.led0(led0),
		.led1(led1),
		.led2(led2),
		.led3(led3),
		.led4(led4),
		.led5(led5),
		.led6(led6),
		.led7(led7) 
		//.bus(bus)
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
//		#100;
		reset = 0;
	end
      
endmodule

