`define AND_CTL 4'b0000
`define OR_CTL 4'b0001
`define ADD_CTL 4'b0010
`define LSL_CTL 4'b0011
`define LSR_CTL 4'b0100
`define SUB_CTL 4'b0110
`define PassB_CTL 4'b0111

`timescale 1ns / 1ps

module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output reg Zero;
    
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin		
        case(ALUCtrl)
            `AND_CTL: BusW <= /*#20*/ BusA & BusB;
			`OR_CTL: BusW <= /*#20*/ BusA | BusB;
			`ADD_CTL: BusW <= /*#20*/ BusA + BusB;
			`LSL_CTL: BusW <= /*#20*/ BusA << BusB;
			`LSR_CTL: BusW <= /*#20*/ BusA >> BusB;
			`SUB_CTL: BusW <= /*#20*/ BusA - BusB;
			`PassB_CTL: BusW <= /*#20*/ BusB;
        endcase

        Zero <= (BusW == 0);
    end
endmodule
