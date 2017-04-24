`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: FEIncorparated
// Engineer: FatallEggor
// Create Date:   11:39:10 12/25/2016
// 
////////////////////////////////////////////////////////////////////////////////

module cpu_tb;

localparam T = 20;

	// Inputs
	reg clk;
	reg reset;
	reg rx_fem;

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
	wire tx_fem;



	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk_in(clk), 
		.reset(reset),
		.rx_fem(rx_fem),
		.tx_fem(tx_fem),
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
		clk = 1'b0;
		reset = 1'b1;
		rx_fem = 1'b1;
		#20;

		reset = 1'b0;
		rx_fem = 1'b0;
		#1280;
		
		rx_fem = 1'b1;
		#1280;
		
		rx_fem = 1'b0;
		#1280;
		
		rx_fem = 1'b1;
		#1280;
		
		rx_fem = 1'b0;
		#1280;
		
		rx_fem = 1'b1;
		#1280;
		
		rx_fem = 1'b0;
		#1280;
		
		rx_fem = 1'b1;
		#1280;
		
		rx_fem = 1'b0;
		#1280;
		
		rx_fem = 1'b1;
		#1280;
	end
      
endmodule

