`timescale 1ns / 1ps
/*
 * Module: InstructionMemory
 *
 * Implements read-only instruction memory
 * 
 */
module InstructionMemory(Data, Address);
   parameter T_rd = 20;
   parameter MemSize = 40;
   
   output [31:0] Data;
   input [63:0]  Address;
   reg [31:0] 	 Data;
   
   /*
    * ECEN 350 Processor Test Functions
    * Texas A&M University
    */
   
   always @ (Address) begin
      case(Address)

	/* Test Program 1:
	 * Program loads constants from the data memory. Uses these constants to test
	 * the following instructions: LDUR, ORR, AND, CBZ, ADD, SUB, STUR and B.
	 * 
	 * Assembly code for test:
	 * 
	 * 0: LDUR X9, [XZR, 0x0]    //Load 1 into x9
	 * 4: LDUR X10, [XZR, 0x8]   //Load a into x10
	 * 8: LDUR X11, [XZR, 0x10]  //Load 5 into x11
	 * C: LDUR X12, [XZR, 0x18]  //Load big constant into x12
	 * 10: LDUR X13, [XZR, 0x20]  //load a 0 into X13
	 * 
	 * 14: ORR X10, X10, X11  //Create mask of 0xf
	 * 18: AND X12, X12, X10  //Mask off low order bits of big constant
	 * 
	 * loop:
	 * 1C: CBZ X12, end  //while X12 is not 0
	 * 20: ADD X13, X13, X9  //Increment counter in X13
	 * 24: SUB X12, X12, X9  //Decrement remainder of big constant in X12
	 * 28: B loop  //Repeat till X12 is 0
	 * 2C: STUR X13, [XZR, 0x20]  //store back the counter value into the memory location 0x20
	 *
	 *
	 *
	 *
	 * LSL/LSR test:
	 *
	 * 34: LDUR X9, [XZR, 0x10]   	//load big constant into x9
	 * 38: LSR X10, X9, #1			//Shift constant right by 1 into x10
	 * 3C: LSR X11, X10, #1			//shift constant right by 1 into x11
	 * 40: LSL X12, X11, #1			//shifts constant left by 1 into x12
	 * 44: LSL X13, X12, #1			//shifts constant left by 1 into x13 
	 * 48: STUR X13, [XZR, 0x28]	//stores back the original value of x8
	 * 50: LDUR X13, [XZR, 0x28]	//loads last stur
	 *
	 *
	 * CBNZ test:
	 *
	 * 54: LDUR X9, [XZR, 0x0]    //Load 1 into x9
	 * 58: LDUR X10, [XZR, 0x8]   //Load a into x10
	 * 5C: LDUR X11, [XZR, 0x10]  //Load 5 into x11
	 * 60: LDUR X12, [XZR, 0x18]  //Load big constant into x12
	 * 64: LDUR X13, [XZR, 0x20]  //load a 0 into X13
	 * 
	 * 68: ORR X10, X10, X11  //Create mask of 0xf
	 * 6C: AND X12, X12, X10  //Mask off low order bits of big constant
	 * 70: STUR X13, [XZR, 0x28] //store big const before skipping loop
	 * loop:
	 * 74: CBNZ X12, end  //while X12 is 0
	 * 78: ADD X13, X13, X9  //Increment counter in X13
	 * 7C: SUB X12, X12, X9  //Decrement remainder of big constant in X12
	 * 80: B loop  //Repeat till X12 is 0
	 * 84: STUR X13, [XZR, 0x20]  //store back the counter value into the memory location 0x20
	 * 88: LDUR X13, [XZR, 0x20] //load big constant
	 *
	 *
	 * BL test:
	 * 8C: LDUR X9, [XZR, 0x0]    //Load 1 into x9
	 * 90: LDUR X10, [XZR, 0x8]   //Load a into x10
	 * 94: LDUR X11, [XZR, 0x10]  //Load 5 into x11
	 * 98: LDUR X12, [XZR, 0x18]  //Load big constant into x12
	 * 9C: LDUR X13, [XZR, 0x20]  //load a 0 into X13
	 * 
	 * A0: ORR X10, X10, X11  //Create mask of 0xf
	 * A4: AND X12, X12, X10  //Mask off low order bits of big constant
	 * A8: STUR X13, [XZR, 0x28] //store big const before skipping loop
	 * loop:
	 * AC: CBZ X12, end  //while X12 is 0
	 * B0: ADD X13, X13, X9  //Increment counter in X13
	 * B4: SUB X12, X12, X9  //Decrement remainder of big constant in X12
	 * B8: BL loop  //Repeat till X12 is 0, stores next addr in x#0
	 * BC: STUR X30, [XZR, 0x20]  //store back the counter value into the memory location 0x20
	 * C0: LDUR X30, [X30, 0x0] //loads the link address from x30
	 */
	

	63'h000: Data = 32'hF84003E9; //LDUR
	63'h004: Data = 32'hF84083EA; //LDUR
	63'h008: Data = 32'hF84103EB; //LDUR
	63'h00c: Data = 32'hF84183EC; //LDUR
	63'h010: Data = 32'hF84203ED; //LDUR
	63'h014: Data = 32'hAA0B014A; //ORR
	63'h018: Data = 32'h8A0A018C; //AND
	63'h01c: Data = 32'hB400008C; //CBZ
	63'h020: Data = 32'h8B0901AD; //ADD
	63'h024: Data = 32'hCB09018C; //SUB
	63'h028: Data = 32'h17FFFFFD; //B
	63'h02c: Data = 32'hF80203ED; //STUR
	63'h030: Data = 32'hF84203ED;  //One last load to place stored value on memdbus for test checking.


	/* Add code for your tests here */

	//LSL LSR tests
	//loads the big constant, right shifts twice, then left shifts twice, stores then loads
	63'h034: Data = 32'hF84183E9; //LDUR
	63'h038: Data = 32'hD340052A; //LSR
	63'h03C: Data = 32'hD340054B; //LSR
	63'h044: Data = 32'hD360056C; //LSL
	63'h048: Data = 32'hD360058D; //LSL
	63'h04C: Data = 32'hF80203ED; //STUR
	63'h050: Data = 32'hF84203ED; //LDUR

	//CBNZ Test
	//same as initial test, but skips over loop and has different stored value
	63'h054: Data = 32'hF84003E9; //LDUR
	63'h058: Data = 32'hF84083EA; //LDUR
	63'h05C: Data = 32'hF84103EB; //LDUR
	63'h060: Data = 32'hF84183EC; //LDUR
	63'h064: Data = 32'hF84203ED; //LDUR
	63'h068: Data = 32'hAA0B014A; //ORR
	63'h06C: Data = 32'h8A0A018C; //AND
	63'h070: Data = 32'hF80203ED; //STUR
	63'h074: Data = 32'hB500008A; //changed to cbnz
	63'h078: Data = 32'h8B0901AD; //ADD
	63'h07C: Data = 32'hCB09018C; //SUB
	63'h080: Data = 32'h17FFFFFD; //B
	63'h084: Data = 32'hF80203ED; //STUR
	63'h088: Data = 32'hF84203ED; //One last load to place stored value on memdbus for test checking.

	//BL test
	//same as initial test, but stores X30 in memory then loads it
	63'h08C: Data = 32'hF84003E9; //LDUR
	63'h090: Data = 32'hF84083EA; //LDUR
	63'h094: Data = 32'hF84103EB; //LDUR
	63'h098: Data = 32'hF84183EC; //LDUR
	63'h09C: Data = 32'hF84203ED; //LDUR
	63'h0A0: Data = 32'hAA0B014A; //ORR
	63'h0A4: Data = 32'h8A0A018C; //AND
	63'h0A8: Data = 32'hF80203ED; //STUR
	63'h0AC: Data = 32'hB400008C; //cbz
	63'h0B0: Data = 32'h8B0901AD; //ADD
	63'h0B4: Data = 32'hCB09018C; //SUB
	63'h0B8: Data = 32'h97FFFFFD; //change to BL
	63'h0BC: Data = 32'hF80203FE; //STUR
	63'h0C0: Data = 32'hF84203FE; //One last load to place stored value on memdbus for test checking.


	default: Data = 32'hXXXXXXXX;
      endcase
   end
endmodule
