`define B    11'b000101xxxxx  //B type
`define CBZ  11'b10110100010

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
	output Reg2Loc;
	output ALUSrc;
	output MemToReg;
	output RegWrite;
	output MemRead;
	output MemWrite;
	output Branch;
	output Uncondbranch;
	output [1:0] ALUOp;
	
	always @(*) begin
		
		casex(Opcode)
			`LDUR: begin
				force Reg2Loc 		= 1'bx;
				force ALUSrc 		= 1'b1;
				force MemToReg		= 1'b1;
				force RegWrite		= 1'b1;
				force MemRead		= 1'b1;
				force MemWrite		= 1'b0;
				force Branch		= 1'b0;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b00;
			end
			`STUR: begin
				force Reg2Loc 		= 1'b1;
				force ALUSrc 		= 1'b1;
				force MemToReg		= 1'bx;
				force RegWrite		= 1'b0;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b1;
				force Branch		= 1'b0;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b00;
			end
			`ADD: begin
				force Reg2Loc 		= 1'b0;
				force ALUSrc 		= 1'b0;
				force MemToReg		= 1'b0;
				force RegWrite		= 1'b1;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b0;
				force Branch		= 1'b0;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b10;
			end
			`SUB: begin
				force Reg2Loc 		= 1'b0;
				force ALUSrc 		= 1'b0;
				force MemToReg		= 1'b0;
				force RegWrite		= 1'b1;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b0;
				force Branch		= 1'b0;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b10;
			end
			`AND: begin
				force Reg2Loc 		= 1'b0;
				force ALUSrc 		= 1'b0;
				force MemToReg		= 1'b0;
				force RegWrite		= 1'b1;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b0;
				force Branch		= 1'b0;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b10;
			end
			`ORR: begin
				force Reg2Loc 		= 1'b0;
				force ALUSrc 		= 1'b0;
				force MemToReg		= 1'b0;
				force RegWrite		= 1'b1;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b0;
				force Branch		= 1'b0;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b10;
			end
			`CBZ: begin
				force Reg2Loc 		= 1'b1;
				force ALUSrc 		= 1'b0;
				force MemToReg		= 1'bx;
				force RegWrite		= 1'b0;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b0;
				force Branch		= 1'b1;
				force Uncondbranch	= 1'b0;
				force ALUOp			= 2'b01;
			end
			`B: begin
				force Reg2Loc 		= 1'bx;
				force ALUSrc 		= 1'bx;
				force MemToReg		= 1'bx;
				force RegWrite		= 1'b0;
				force MemRead		= 1'b0;
				force MemWrite		= 1'b0;
				force Branch		= 1'bx;
				force Uncondbranch	= 1'b1;
				force ALUOp			= 2'bxx;
			end
		endcase
	end
	
endmodule