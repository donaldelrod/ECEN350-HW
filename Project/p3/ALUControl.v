`timescale 1ns / 1ps
module ALUControl(ALUCtrl, ALUop, Opcode); 
    
	input [1:0] ALUop; 
    input [10:0] Opcode; 
    output reg [3:0] ALUCtrl; 
    
	always @(*) begin
		//#2;
		case (ALUop)
			2'b00: ALUCtrl = 4'b0010;  //LDUR STUR
			2'b01: ALUCtrl = 4'b0111;
			2'b10: begin
				casex (Opcode)
					11'b10001011xxx: ALUCtrl = 4'b0010; //ADD
					11'b11001011xxx: ALUCtrl = 4'b0110; //SUB
					11'b10001010xxx: ALUCtrl = 4'b0000; //AND
					11'b10101010xxx: ALUCtrl = 4'b0001; //ORR
					11'b11010011010: ALUCtrl = 4'b0100; //LSR
					11'b11010011011: ALUCtrl = 4'b0011; //LSL
					default: ALUCtrl = 4'b1111;
				endcase
			end
			default: ALUCtrl = 4'b1111;
		endcase
	end

endmodule