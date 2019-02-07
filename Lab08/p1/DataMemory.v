`timescale 1ns / 1ps
module DataMemory(ReadData, Address, WriteData, MemoryRead, MemoryWrite, Clock); 
    
	parameter n = 64;
	
	input [n-1:0] Address, WriteData; 
    input MemoryRead, MemoryWrite, Clock; 
    output [n-1:0] ReadData;
	
	reg [n-1:0] data [n-1:0];
    
	always @(negedge(Clock)) begin
		if (~(MemoryRead && MemoryWrite)) begin //check to make sure both aren't 1
			if (MemoryWrite) begin
				#20;
				data[Address] <= WriteData; //writes to register if MemoryWrite is 1 and MemoryRead is not
			end
		end
	end
	
	always @(posedge(Clock)) begin
		if (~(MemoryRead && MemoryWrite)) begin //check to make sure both aren't 1
			if (MemoryRead) begin
				#20;
				force ReadData = data[Address]; //outputs the data at the address specified to the output bus if MemoryRead is 1 and MemoryWrite is not
			end
		end
	end
	
	
	
	
endmodule