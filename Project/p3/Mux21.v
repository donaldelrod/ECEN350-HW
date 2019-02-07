`timescale 1ns / 1ps
module Mux21(in, sel, out);

	input sel;
	input [1:0]in;
	output out;
	wire w1, w2, w3, w4;

	not not1(w1, sel);   //gets the inverse of sel
	and and1(w2, in[1], sel);  //masks B with a 0 if sel is 0, passes it through if sel is 1
	and and2(w3, in[0], w1);  //masks A with a 0 if ~sel is 0, passes it through if ~sel is 1
	or or1(w4, w2, w3);   //allows whichever value isn't 0 to pass thru, or pass 0 if both are 0
	assign out = w4;

endmodule