`timescale 1ns / 1ps
`define STRLEN 32
module ALUControl_tb;

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
	
	//Inputs
	reg [1:0] ALUOp;
	reg [10:0] Opcode;
	
	//Counter
	reg [7:0] passed;
	//Outputs
	wire [3:0] ALUCtrl;
	
	ALUControl uut(.ALUCtrl(ALUCtrl),
				   .ALUop(ALUOp), 
				   .Opcode(Opcode));
				   
	initial begin
		passed = 8'd0;
		{ALUOp, Opcode} = {2'b00, 11'b000_0000_0000};
		#5;
		
		{ALUOp, Opcode} = {2'b00, 11'b000_0000_0000};
		#5;
		passTest(ALUCtrl, 4'b0010, "Test Case 1", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b01, 11'b000_0000_0000};
		#5;
		passTest(ALUCtrl, 4'b0111, "Test Case 2", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b110_0101_1000};
		#5;
		passTest(ALUCtrl, 4'b0110, "Test Case 3", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b10101010000};
		#5;
		passTest(ALUCtrl, 4'b0001, "Test Case 4", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b10001010000};
		#5;
		passTest(ALUCtrl, 4'b0000, "Test Case 5", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b10001011000};
		#5;
		passTest(ALUCtrl, 4'b0010, "Test Case 6", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b10101010000};
		#5;
		passTest(ALUCtrl, 4'b0001, "Test Case 7", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b10001011000};
		#5;
		passTest(ALUCtrl, 4'b0010, "Test Case 8", passed);
		#5;
		
		{ALUOp, Opcode} = {2'b10, 11'b11001011000};
		#5;
		passTest(ALUCtrl, 4'b0110, "Test Case 9", passed);
		#5;
		
		allPassed(passed, 8'd9);
		$finish;
	end
endmodule
