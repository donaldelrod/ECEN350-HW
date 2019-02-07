`timescale 1ns / 1ps
module ALUControl(ALUCtrl, ALUop, Opcode); 
    
	input [1:0] ALUop; 
    input [10:0] Opcode; 
    output reg [3:0] ALUCtrl; 
    
	always @(*) begin
		//#2;
		case (ALUop)
			2'b00: ALUCtrl = 4'b0010;
			2'b01: ALUCtrl = 4'b0111;
			2'b10: begin
				case (Opcode[10:3])
					8'b10001011: ALUCtrl = 4'b0010;
					8'b11001011: ALUCtrl = 4'b0110;
					8'b10001010: ALUCtrl = 4'b0000;
					8'b10101010: ALUCtrl = 4'b0001;
					default: ALUCtrl = 4'b1111;
				endcase
			end
			default: ALUCtrl = 4'b1111;
		endcase
	end

endmodule