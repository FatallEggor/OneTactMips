`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:31:23 12/16/2016
// Design Name:   ram
// Module Name:   /home/egor/Projects/verilog/contr_tests/final/mips1/data_mem_tb.v
// Project Name:  mips1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_mem_tb;

localparam T = 20;

	// Inputs
	reg clk;
	reg we;
	reg [31:0] addr;
	reg [31:0] d_in;

	// Outputs
	wire [31:0] d_out;

	// Instantiate the Unit Under Test (UUT)
	ram uut (
		.clk(clk), 
		.we(we), 
		.addr(addr), 
		.d_in(d_in), 
		.d_out(d_out)
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
		we = 0;
		addr = 0;
		d_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		we = 0;
		addr = 32'h00000001;
		d_in = 32'h43214312;  
		#100;
		        
		we = 1;
		addr = 32'h00000001;
		d_in = 32'h43214312;  
		#100;
		        
		we = 0;
		addr = 32'h00000001;
		d_in = 32'h43214312;  
		#100;
		
		// Add stimulus here

	end
      
endmodule

