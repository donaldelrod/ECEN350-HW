`timescale 1ns / 1ps
`define STRLEN 32
module SingleCycleControlTest;


	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask


	// Inputs
	reg [10:0] OpCode;
	
	// Outputs
	wire Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch;
	wire [1:0] ALUOp;
	reg [7:0] passed;
	reg [7:0] numTests;
	// Instantiate the Unit Under Test (UUT)
	SingleCycleControl uut(
		.Reg2Loc(Reg2Loc),
		.ALUSrc(ALUSrc),
		.MemToReg(MemToReg),
		.RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.Uncondbranch(Uncondbranch),
		.ALUOp(ALUOp),
		.Opcode(OpCode));

	initial begin
		// Initialize Inputs
		OpCode = 11'b0000_0000_000;
		passed = 7'b0;
		numTests = 7'b0;
		#3;
		
		OpCode = 11'b11111000010; //LDUR Instruction
		#3;
		passTest({Uncondbranch, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 2'b00}, "LDUR Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b11111000000; //STUR Instruction
		#3;
		passTest({Reg2Loc, Uncondbranch, Branch, MemRead, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b1, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 2'b00}, "STUR Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b10001011000; //ADD Instruction
		#3;
		passTest({Reg2Loc, Uncondbranch, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b10}, "ADD Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b11001011000; //SUB Instruction
		#3;
		passTest({Reg2Loc, Uncondbranch, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b10}, "SUB Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b10001010000; //AND Instruction
		#3;
		passTest({Reg2Loc, Uncondbranch, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b10}, "AND Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b10101010000; //ORR Instruction
		#3;
		passTest({Reg2Loc, Uncondbranch, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b10}, "ORR Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b10110100_010; //CBZ Instruction
		#3;
		passTest({Reg2Loc, Uncondbranch, Branch, MemRead, MemWrite, ALUSrc, RegWrite, ALUOp},
			 {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01}, "CBZ Opcode", passed);
		numTests = numTests + 1;
		
		OpCode = 11'b000101_00001; //B Instruction
		#3;
		passTest({Uncondbranch, MemRead, MemWrite, RegWrite},
			 {1'b1, 1'b0, 1'b0, 1'b0}, "B Opcode", passed);
		numTests = numTests + 1;
		
		allPassed(passed, numTests);

		$finish;
	end
      
endmodule

