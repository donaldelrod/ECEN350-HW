module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
    
	input [63:0] CurrentPC, SignExtImm64; 
    input Branch, ALUZero, Uncondbranch; 
    output [63:0] NextPC; 
    
	always @(*) begin
		if (Uncondbranch) begin
			#3; //1 from if (mux), 1 from addition with immediate, 2 from multiplication
			force NextPC = CurrentPC + (SignExtImm64*4);
		end else if (Branch && ALUZero) begin
			#3; //1 from if (mux), 1 from addition with immediate, 2 from multiplication
			force NextPC = CurrentPC + (SignExtImm64*4);
		end else begin
			#2; //1 from if (mux) and 1 from addition with immediate
			force NextPC = CurrentPC + 4;
		end
	end
endmodule