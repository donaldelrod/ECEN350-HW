`define B    11'b000101xxxxx  //B type
`define CBZ  11'b101101000XX

`define ADDI 11'b1001000100x  //I type
`define ORRI 11'b1011001000x  //I type
`define SUBI 11'b1101000100x  //I type
`define ANDI 11'b1001001000x  //I type

`define ORR  11'b10101010000  //R type
`define ADD  11'b10001011000  //R type
`define SUB  11'b11001011000  //R type
`define AND  11'b10001010000  //R type

`define STUR 11'b11111000000  //D type
`define LDUR 11'b11111000010  //D type

`define LSL  11'b11010011011  //   R type
`define LSR  11'b11010011010  //   R type

`timescale 1ns / 1ps

module SingleCycleControl(Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch, ALUOp, Opcode);
	input [10:0] Opcode;
	output reg Reg2Loc;
	output reg ALUSrc;
	output reg MemToReg;
	output reg RegWrite;
	output reg MemRead;
	output reg MemWrite;
	output reg Branch;
	output reg Uncondbranch;
	output reg [1:0] ALUOp;
	
	always @(*) begin
		
		casex(Opcode)
			`LDUR: begin
				Reg2Loc 		= 1'bx;
				ALUSrc 			= 1'b1;
				MemToReg		= 1'b1;
				RegWrite		= 1'b1;
				MemRead			= 1'b1;
				MemWrite		= 1'b0;
				Branch			= 1'b0;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b00;
			end
			`STUR: begin
				Reg2Loc 		= 1'b1;
				ALUSrc 			= 1'b1;
				MemToReg		= 1'bx;
				RegWrite		= 1'b0;
				MemRead			= 1'b0;
				MemWrite		= 1'b1;
				Branch			= 1'b0;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b00;
			end
			`ADD: begin
				Reg2Loc 		= 1'b0;
				ALUSrc 			= 1'b0;
				MemToReg		= 1'b0;
				RegWrite		= 1'b1;
				MemRead			= 1'b0;
				MemWrite		= 1'b0;
				Branch			= 1'b0;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b10;
			end
			`SUB: begin
				Reg2Loc 		= 1'b0;
				ALUSrc 			= 1'b0;
				MemToReg		= 1'b0;
				RegWrite		= 1'b1;
				MemRead			= 1'b0;
				MemWrite		= 1'b0;
				Branch			= 1'b0;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b10;
			end
			`AND: begin
				Reg2Loc 		= 1'b0;
				ALUSrc 			= 1'b0;
				MemToReg		= 1'b0;
				RegWrite		= 1'b1;
				MemRead			= 1'b0;
				MemWrite		= 1'b0;
				Branch			= 1'b0;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b10;
			end
			`ORR: begin
				Reg2Loc 		= 1'b0;
				ALUSrc 			= 1'b0;
				MemToReg		= 1'b0;
				RegWrite		= 1'b1;
				MemRead			= 1'b0;
				MemWrite		= 1'b0;
				Branch			= 1'b0;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b10;
			end
			`CBZ: begin
				Reg2Loc 		= 1'b1;
				ALUSrc 			= 1'b0;
				MemToReg		= 1'bx;
				RegWrite		= 1'b0;
				MemRead			= 1'b0;
				MemWrite		= 1'b0;
				Branch			= 1'b1;
				Uncondbranch	= 1'b0;
				ALUOp			= 2'b01;
			end
			`B: begin
				Reg2Loc 		= 1'bx;
				ALUSrc 			= 1'bx;
				MemToReg		= 1'bx;
				RegWrite		= 1'b0;
				MemRead			= 1'b0;
				MemWrite		= 1'b0;
				Branch			= 1'bx;
				Uncondbranch	= 1'b1;
				ALUOp			= 2'bxx;
			end
		endcase
	end
	
endmodule