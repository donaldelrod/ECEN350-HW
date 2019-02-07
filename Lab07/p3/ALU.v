`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define LSL 4'b0011
`define LSR 4'b0100
`define SUB 4'b0110
`define PassB 4'b0111


module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
    
    parameter n = 64;

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output reg Zero;
    
    reg     [n-1:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
		
		assign Zero = (BusW == 0);
		
		// if (BusW == 0) begin
			// Zero = 1'b1;
		// end else begin
			// assign Zero = 1'b0;
		// end
		
        case(ALUCtrl)
            `AND: BusW <= #20 BusA & BusB;
			`OR: BusW <= #20 BusA | BusB;
			`ADD: BusW <= #20 BusA + BusB;
			`LSL: BusW <= #20 BusA << BusB;
			`LSR: BusW <= #20 BusA >> BusB;
			`SUB: BusW <= #20 BusA - BusB;
			`PassB: BusW <= #20 BusB;
        endcase
    end

    //assign #1 Zero = 
endmodule
