module subst 
(
	input wire [31:0]	in,
	output wire [31:0]	out
);

	reg  [3:0] sub0 [15:0];
	reg  [3:0] sub1 [15:0];
	reg  [3:0] sub2 [15:0];
	reg  [3:0] sub3 [15:0];
	reg  [3:0] sub4 [15:0];
	reg  [3:0] sub5 [15:0];
	reg  [3:0] sub6 [15:0];
	reg  [3:0] sub7 [15:0];

	wire [3:0] out0, out1, out2, out3, out4, out5, out6, out7; 

	initial
	begin
	sub0[0] = 4'hc; sub0[1] = 4'h4; sub0[2] = 4'h6; sub0[3] = 4'h2;
	sub0[4] = 4'ha; sub0[5] = 4'h5; sub0[6] = 4'hb; sub0[7] = 4'h9;
	sub0[8] = 4'he; sub0[9] = 4'h8; sub0[10] = 4'hd; sub0[11] = 4'h7; 
	sub0[12] = 4'h0; sub0[13] = 4'h3; sub0[14] = 4'hf; sub0[15] = 4'h1; 

	sub1[0] = 4'h6; sub1[1] = 4'h8; sub1[2] = 4'h2; sub1[3] = 4'h3;
	sub1[4] = 4'h9; sub1[5] = 4'ha; sub1[6] = 4'h5; sub1[7] = 4'hc;
	sub1[8] = 4'h1; sub1[9] = 4'he; sub1[10] = 4'h4; sub1[11] = 4'h7; 
	sub1[12] = 4'hb; sub1[13] = 4'hd; sub1[14] = 4'h0; sub1[15] = 4'hf; 

	sub2[0] = 4'hb; sub2[1] = 4'h3; sub2[2] = 4'h5; sub2[3] = 4'h8;
	sub2[4] = 4'h2; sub2[5] = 4'hf; sub2[6] = 4'ha; sub2[7] = 4'hd;
	sub2[8] = 4'he; sub2[9] = 4'h1; sub2[10] = 4'h7; sub2[11] = 4'h4; 
	sub2[12] = 4'hc; sub2[13] = 4'h9; sub2[14] = 4'h6; sub2[15] = 4'h0; 
	
	sub3[0] = 4'hc; sub3[1] = 4'h8; sub3[2] = 4'h2; sub3[3] = 4'h1;
	sub3[4] = 4'hd; sub3[5] = 4'h4; sub3[6] = 4'hf; sub3[7] = 4'h6;
	sub3[8] = 4'h7; sub3[9] = 4'h0; sub3[10] = 4'ha; sub3[11] = 4'h5; 
	sub3[12] = 4'h3; sub3[13] = 4'he; sub3[14] = 4'h9; sub3[15] = 4'hb; 
	
	sub4[0] = 4'h7; sub4[1] = 4'hf; sub4[2] = 4'h5; sub4[3] = 4'ha;
	sub4[4] = 4'h8; sub4[5] = 4'h1; sub4[6] = 4'h6; sub4[7] = 4'hd;
	sub4[8] = 4'h0; sub4[9] = 4'h9; sub4[10] = 4'h3; sub4[11] = 4'he; 
	sub4[12] = 4'hb; sub4[13] = 4'h4; sub4[14] = 4'h2; sub4[15] = 4'hc; 
	
	sub5[0] = 4'h5; sub5[1] = 4'hd; sub5[2] = 4'hf; sub5[3] = 4'h6;
	sub5[4] = 4'h9; sub5[5] = 4'h2; sub5[6] = 4'hc; sub5[7] = 4'ha;
	sub5[8] = 4'hb; sub5[9] = 4'h7; sub5[10] = 4'h8; sub5[11] = 4'h1; 
	sub5[12] = 4'h4; sub5[13] = 4'h3; sub5[14] = 4'he; sub5[15] = 4'h0; 
	
	sub6[0] = 4'h8; sub6[1] = 4'he; sub6[2] = 4'h2; sub6[3] = 4'h5;
	sub6[4] = 4'h6; sub6[5] = 4'h9; sub6[6] = 4'h1; sub6[7] = 4'hc;
	sub6[8] = 4'hf; sub6[9] = 4'h4; sub6[10] = 4'hb; sub6[11] = 4'h0; 
	sub6[12] = 4'hd; sub6[13] = 4'ha; sub6[14] = 4'h3; sub6[15] = 4'h7; 
	
	sub7[0] = 4'h1; sub7[1] = 4'h7; sub7[2] = 4'he; sub7[3] = 4'hd;
	sub7[4] = 4'h0; sub7[5] = 4'h5; sub7[6] = 4'h8; sub7[7] = 4'h3;
	sub7[8] = 4'h4; sub7[9] = 4'hf; sub7[10] = 4'ha; sub7[11] = 4'h6; 
	sub7[12] = 4'h9; sub7[13] = 4'hc; sub7[14] = 4'hb; sub7[15] = 4'h2; 
	
	end


	assign out7 = sub7[in[31:28]];
	assign out6 = sub6[in[27:24]];
	assign out5 = sub5[in[23:20]];
	assign out4 = sub4[in[19:16]];
	assign out3 = sub3[in[15:12]];
	assign out2 = sub2[in[11:8]];
	assign out1 = sub1[in[7:4]];
	assign out0 = sub0[in[3:0]];

	assign out = {out7, out6, out5, out4, out3, out2, out1, out0};
endmodule
