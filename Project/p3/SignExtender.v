`define B_SE    	11'b000101xxxxx  //B type
`define BL_SE		11'b100101xxxxx
`define CBZ_SE  	11'b101101000XX
`define CBNZ_SE		11'b10110101xxx  //CB type


`define ADDI_SE 	11'b1001000100x  //I type
`define ORRI_SE 	11'b1011001000x  //I type
`define SUBI_SE 	11'b1101000100x  //I type
`define ANDI_SE 	11'b1001001000x  //I type
`define ADDIS_SE 	11'b1011000100x  //I type
`define EORI_SE		11'b1011001000x  //I type
`define SUBIS_SE	11'b1111000100x
`define ANDIS_SE	11'b1111001000x

`define ORR_SE  	11'b10101010000  //R type
`define ADD_SE  	11'b10001011000  //R type
`define SUB_SE  	11'b11001011000  //R type
`define AND_SE  	11'b10001010000  //R type

`define STUR_SE 	11'b11111000000  //D type
`define LDUR_SE 	11'b11111000010  //D type

`define LSL_SE  	11'b11010011011  //R type
`define LSR_SE  	11'b11010011010  //R type

`timescale 1ns / 1ps

module SignExtender(Instr, Out);

	input [31:0] Instr;	
	reg [25:0] Bimm;	
	reg [18:0] CBimm;	
	reg [8:0] Dimm;
	reg [11:0] Iimm;
	reg [5:0] Rimm;
	
	reg MSB;
	reg [2:0] instr_type;
	
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
		assign Rimm = {6{1'b0}};

		casex(Instr[31:21])
			`B_SE, `BL_SE: begin
				assign Bimm = Instr[25:0]; //26
				assign MSB = Instr[25];
				assign instr_type = 3'b000;
			end
			`CBZ_SE, `CBNZ_SE: begin
				assign CBimm = Instr[23:5];
				assign MSB = Instr[23];
				assign instr_type = 3'b001;
			end
			`STUR_SE, `LDUR_SE: begin
				assign Dimm = Instr[20:12];
				assign MSB = Instr[20];
				assign instr_type = 3'b010;
			end
			`ADDI_SE, `ANDI_SE, `ADDIS_SE, `ORRI_SE, `SUBI_SE, `EORI_SE, `SUBIS_SE, `ANDIS_SE: begin
				assign Iimm = Instr[21:10];
				assign MSB = 1'b0;
				assign instr_type = 3'b011;
			end
			`ADD_SE, `SUB_SE, `AND_SE, `ORR_SE, `LSL_SE, `LSR_SE: begin
				assign Rimm = Instr[15:10];
				assign MSB = 1'b0;
				assign instr_type = 3'b100;
			end



		endcase
		
		// if (Instr[31:26] == 6'b000101) begin //if the instruction is B type
		// 	assign Bimm = Instr[25:0]; //26
		// 	assign MSB = Instr[25];
		// 	assign instr_type = 2'b00;
		// end else if ( Instr[31:24] == 8'b10110100 || Instr[31:24] == 8'b01010100 ) begin //if the instruction is CB type
		// 	assign CBimm = Instr[23:5];
		// 	assign MSB = Instr[23];
		// 	assign instr_type = 2'b01;
		// end else if ( Instr[31:21] == 11'h7C0 /*STUR*/ || Instr[31:21] == 11'h7C2 /*LDUR*/ ) begin
		// 	assign Dimm = Instr[20:12];
		// 	assign MSB = Instr[20];
		// 	assign instr_type = 2'b10;
		// end else if ( Instr[31:26] == 6'b100100 /*ADDI ANDI*/ || Instr[31:26] == 6'b101100 /*ADDIS ORRI*/ || Instr[31:22] == 10'b1101000100 /*SUBI*/ || Instr[31:22] == 10'b1101001000 /*EORI*/ || Instr[31:22] == 10'b1111000100 /*SUBIS*/ || Instr[31:22] == 10'b1111001000 /*ANDIS*/) begin
		// 	assign Iimm = Instr[21:10];
		// 	assign MSB = 1'b0;
		// 	assign instr_type = 2'b11;
		// end
		
		case(instr_type)
			3'b000: assign Out = {{38{MSB}}, Bimm};
			3'b001: assign Out = {{45{MSB}}, CBimm};
			3'b010: assign Out = {{55{MSB}}, Dimm};
			3'b011: assign Out = {{52{MSB}}, Iimm};
			3'b100: assign Out = {{58{MSB}}, Rimm};
			default: assign Out = 64'hFFFFFFFFFFFFFFF;
		endcase
		
		//assign instr_type = 2'b11;
		
	end
	
endmodule