`timescale 1ns / 1ps
module ALUControl(ALUCtrl, ALUop, Opcode); 
    
	input [1:0] ALUop; 
    input [10:0] Opcode; 
    output [3:0] ALUCtrl; 
    
	always @(*) begin
		#2;
		case (ALUop)
			2'b00: force ALUCtrl = 4'b0010;
			2'b01: force ALUCtrl = 4'b0111;
			2'b10: begin
				case (Opcode[10:3])
					8'b10001011: force ALUCtrl = 4'b0010;
					8'b11001011: force ALUCtrl = 4'b0110;
					8'b10001010: force ALUCtrl = 4'b0000;
					8'b10101010: force ALUCtrl = 4'b0001;
					default: force ALUCtrl = 4'b1111;
				endcase
			end
			default: force ALUCtrl = 4'b1111;
		endcase
	end

endmodule