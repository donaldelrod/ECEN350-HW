`timescale 1ns / 1ps
module SignExtender(Instr, Out);

	input [31:0] Instr;
	//output [63:0] Out;
	
	reg [25:0] Bimm;
	//reg [5:0] Bop;
	
	reg [18:0] CBimm;
	//reg [7:0] CBop;
	
	reg [8:0] Dimm;
	//reg [10:0] Dop;
	
	reg [11:0] Iimm;
	
	reg MSB;
	reg [1:0] instr_type;
	
	output reg [63:0] Out;
	
	
	always @(Instr) begin
	
		//assign Bimm = Instr[25:0]; //26
		//assign Bop = Instr[31:26]; //6
		
		//assign CBimm = Instr[26:5]; //19
		//assign CBop = Instr[31:24]; //8
		
		//assign Dimm = Instr[20:12]; //9
		//assign Dop = Instr[31:21]; //11
		
		assign MSB = 1'b0;
		assign Bimm = {26{1'b0}};
		assign CBimm = {19{1'b0}};
		assign Dimm = {9{1'b0}};
		
		if (Instr[31:26] == 6'b000101) begin //if the instruction is B type
			assign Bimm = Instr[25:0]; //26
			assign MSB = Instr[25];
			assign instr_type = 2'b00;
		end else if ( Instr[31:24] == 8'b10110100 || Instr[31:24] == 8'b01010100 ) begin //if the instruction is CB type
			assign CBimm = Instr[23:5];
			assign MSB = Instr[23];
			assign instr_type = 2'b01;
		end else if ( Instr[31:21] == 11'h7C0 /*STUR*/ || Instr[31:21] == 11'h7C2 /*LDUR*/ ) begin
			assign Dimm = Instr[20:12];
			assign MSB = Instr[20];
			assign instr_type = 2'b10;
		end else if ( Instr[31:26] == 6'b100100 /*ADDI ANDI*/ || Instr[31:26] == 6'b101100 /*ADDIS ORRI*/ || Instr[31:22] == 10'b1101000100 /*SUBI*/ || Instr[31:22] == 10'b1101001000 /*EORI*/ || Instr[31:22] == 10'b1111000100 /*SUBIS*/ || Instr[31:22] == 10'b1111001000 /*ANDIS*/) begin
			assign Iimm = Instr[21:10];
			assign MSB = 1'b0;
			assign instr_type = 2'b11;
		end
		
		case(instr_type)
			2'b00: assign Out = {{38{MSB}}, Bimm};
			2'b01: assign Out = {{45{MSB}}, CBimm};
			2'b10: assign Out = {{55{MSB}}, Dimm};
			2'b11: assign Out = {{52{MSB}}, Iimm};
			default: assign Out = 64'hFFFFFFFFFFFFFFF;
		endcase
		
		//assign instr_type = 2'b11;
		
	end
	
endmodule