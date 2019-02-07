`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RW;
	input [4:0] RA;
	input [4:0] RB;
    input RegWr;
    input Clk;
	
	
    reg [31:0] registers [63:0];
	
	initial begin
		registers[31] <= 64'h0;
	end
	
     
    assign /*#2*/ BusA = registers[RA];
    assign /*#2*/ BusB = registers[RB];
     
    always @ (negedge Clk) begin
        if(RegWr && RW != 31)
            registers[RW] <= /*#3*/ BusW;
    end
endmodule
