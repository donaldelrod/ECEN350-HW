`define STRLEN 15
`timescale 1ns / 1ps
module SignExtenderTest;

   task passTest;
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0]         passed;
      
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
   reg [31:0]     Instr;
   reg [7:0]      passed;

   // Outputs
   wire           Out;

   // Instantiate the Device Under Test (DUT)
   SignExtender dut (
		.Instr(Instr), 
		.Out(Out)
	        );

   initial begin
      // Initialize Inputs
	  Instr = 32'h00000000;
      
      passed = 0;

      // Add stimulus here
	  //B                    |
      #90; Instr = 32'b00010100000000000000101010101001; #40; //passTest(Out, 32'b00000000000000000000101010101001, "00000000000000101010101001", passed);
      #90; Instr = 32'b00010111000000000000101010101001; #40; //passTest(Out, 32'b11111111111111111111101010101001, "11111111111111101010101001", passed);
	  //CB                     |
	  #90; Instr = 32'b10110100000000000111101010100000; #40; //passTest(Out, 32'b00000000000000000000001111010101, "00000000000000101010101001", passed);
      #90; Instr = 32'b10110100110000000000101010100000; #40; //passTest(Out, 32'b11111111111111100000000001010101, "11111111111111101010101001", passed);
	  //D                         | 
	  #90; Instr = 32'b11111000010000111111000000000000; #40; //passTest(Out, 32'b000111111, "00000000000000101010101001", passed);
      #90; Instr = 32'b11111000010100111111000000000000; #40; //passTest(Out, 32'b11111111111111111111101010101001, "11111111111111101010101001", passed);
	  //I                        |
	  #90; Instr = 32'b10010001000000111111110000000000; #40; //passTest(Out, 32'b000111111, "00000000000000101010101001", passed);
      #90; Instr = 32'b10010001001000111111110000000000; #40; //passTest(Out, 32'b11111111111111111111101010101001, "11111111111111101010101001", passed);
      
      //allPassed(passed, 4);

   end
   
endmodule
