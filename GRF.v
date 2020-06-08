`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:05 11/23/2018 
// Design Name: 
// Module Name:    GRF 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module GRF(	               ///寄存器内部转发问题？记得检查这里！！！！
    input [4:0] RA1,
    input [4:0] RA2,
    input [4:0] WA,
    input [31:0] Wdata,
    input WE,
    input Reset,
    input Clk,
	 input [31:0]Pc,
    output reg [31:0] Rdata1,
    output reg [31:0] Rdata2
    );
	reg [31:0] Registers[0:31];
	integer i=0;
	
	initial begin
		for (i=0;i<32;i=i+1)
			Registers[i]<=32'h00000000;
	end
	
	always @(posedge Clk)begin
		if (Reset)
			for (i=0;i<32;i=i+1)
				Registers[i]<=32'h00000000;
		else
			if (WE)begin
				$display("%d@%h: $%d <= %h",$time,Pc,WA,Wdata);
				Registers[WA]=WA?Wdata:0;
			end
	end

	always @(*)begin
		if (RA1==WA && WE && WA!=0)
			Rdata1<=Wdata;
		else
			Rdata1<=Registers[RA1];
		if (RA2==WA && WE && WA!=0)
			Rdata2<=Wdata;
		else
			Rdata2<=Registers[RA2];
	end
	
endmodule
