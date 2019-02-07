`timescale 1ns / 1ps
module HalfAdd(A, B, Sum, Cout);

	input A, B;        //inputs to the half adder
	output Sum, Cout;    //outputs of the half adder
	wire w1, w2, w3, w4;  //internal wires
	
	nand nand1(w1, A, B);  //first nand, gets internal signal as well as the carry out
	nand nand5(w4, w1, w1);
	assign Cout = w4;    //sets the carry out to the result of the first nand
	nand nand2(w2, B, w1);   //nands B with the first internal signal
	nand nand3(w3, A, w1);   //nands A with the first internal signal
	nand nand4(Sum, w2, w3);   //sets the output to the nand of the 2nd and 3rd internal signals

endmodule