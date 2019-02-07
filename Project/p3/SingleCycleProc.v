`timescale 1ns / 1ps

`include "InstructionMemory.v"
`include "SignExtender.v"
`include "RegisterFile.v"
`include "NextPClogic.v"
`include "ALU.v"
`include "ALUControl.v"
`include "SingleCycleControl.v"
`include "DataMemory.v"

module SingleCycleProc(CLK, Reset_L, startPC, currentPC, dMemOut);
	input CLK;
	input Reset_L;
	input [63:0] startPC;
	output reg [63:0] currentPC;
	output [63:0] dMemOut;
		
	//all the wires needed to implement data path
	wire BranchLink_w, Reg2Loc_w, Uncondbranch_w, MemRead_w, MemToReg_w, MemWrite_w, ALUSrc_w, RegWrite_w, ALUZero_w;
	
	wire [1:0] ALUOp_w, Branch_w;
	
	wire [3:0] ALUCtrl_w;
	
	wire [4:0] RB_w, RW_w;
	wire [63:0] BusW_w;
	
	wire [63:0] SignExt64_w, ALUOutput_w, RegOutA_w, RegOutB_w, ALUInput_w;
	wire [31:0] Instr;
	wire [63:0] NextInstrAddr_w;
	
	
	InstructionMemory InstrMem (
		.Address(currentPC),
		.Data(Instr)
	);
	
	NextPClogic NextPCLogic (
		.CurrentPC(currentPC),
		.SignExtImm64(SignExt64_w),
		.Branch(Branch_w),
		.ALUZero(ALUZero_w),
		.Uncondbranch(Uncondbranch_w),
		.NextPC(NextInstrAddr_w)
	);
	
	SignExtender SignExtend (
		.Instr(Instr),
		.Out(SignExt64_w)
	);
	
	RegisterFile RegFile (
		.BusW(BusW_w),
		.RA(Instr[9:5]),
		.RB(RB_w),
		.RW(RW_w),
		.RegWr(RegWrite_w),
		.Clk(CLK),
		.BusA(RegOutA_w),
		.BusB(RegOutB_w)
	);
	
	SingleCycleControl SingCycCont (
		.Opcode(Instr[31:21]),
		.Reg2Loc(Reg2Loc_w),
		.ALUSrc(ALUSrc_w),
		.MemToReg(MemToReg_w),
		.RegWrite(RegWrite_w),
		.MemRead(MemRead_w),
		.MemWrite(MemWrite_w),
		.Branch(Branch_w),
		.Uncondbranch(Uncondbranch_w),
		.ALUOp(ALUOp_w),
		.BranchLink(BranchLink_w)
	);
	
	ALUControl ALUCont (
		.ALUop(ALUOp_w),
		.Opcode(Instr[31:21]),
		.ALUCtrl(ALUCtrl_w)
	);
	
	ALU ALU_Unit (
		.BusA(RegOutA_w),
		.BusB(ALUInput_w),
		.BusW(ALUOutput_w),
		.Zero(ALUZero_w),
		.ALUCtrl(ALUCtrl_w)
	);
	
	DataMemory DataMem (
		.WriteData(RegOutB_w),
		.Address(ALUOutput_w),
		.Clock(CLK),
		.MemoryRead(MemRead_w),
		.MemoryWrite(MemWrite_w),
		.ReadData(dMemOut)
	);

	assign RB_w = Reg2Loc_w ? Instr[4:0] : Instr[20:16];
	assign RW_w = BranchLink_w ? 5'b11110 : Instr[4:0];
	assign ALUInput_w = ALUSrc_w ? SignExt64_w : RegOutB_w;

	// always @(*) begin
	// 	dMemOut = BusW_w;
	// end
	
	always @ (negedge CLK, negedge Reset_L) begin
		if(~Reset_L) currentPC = startPC;
		else         currentPC = NextInstrAddr_w;
	end
	
	
	assign BusW_w = BranchLink_w ? (currentPC + 4) : (MemToReg_w ? dMemOut : ALUOutput_w);
	
 
endmodule