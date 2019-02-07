`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
    
	input [63:0] CurrentPC, SignExtImm64; 
    input ALUZero, Uncondbranch; 
	input [1:0] Branch;
    output reg [63:0] NextPC; 
    
	always @(*) begin
	#3;
		if (Uncondbranch || (Branch[0] && ALUZero) || (Branch[1] && !ALUZero)) begin
			//#3; //1 from if (mux), 1 from addition with immediate, 2 from multiplication
			NextPC = CurrentPC + (SignExtImm64*4);
		/*end else if () begin
			#3; //1 from if (mux), 1 from addition with immediate, 2 from multiplication
			force NextPC = CurrentPC + (SignExtImm64*4);
		*/end else begin
			//#2; //1 from if (mux) and 1 from addition with immediate
			NextPC = CurrentPC + 4;
		end
	end
endmodule