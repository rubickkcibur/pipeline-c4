`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:00 11/24/2018 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] Address,
    input [31:0] Wdata,
    input DMld,
    input Reset,
    input Clk,
	 input [3:0]BE,
	 input [31:0]Pc,
    output[31:0] Rdata
    );
	reg [31:0] RAM[0:4095];
	integer i=0;
	wire [11:0]add;
	
	assign add=Address[13:2];
	initial begin
		for (i=0;i<4095;i=i+1)
			RAM[i]<=0;
	end
	
	always @(posedge Clk)begin
		if (Reset)
			for (i=0;i<4095;i=i+1)
				RAM[i]<=0;
		else 
			if(~DMld) begin
				if (BE[0])
					RAM[add][7:0]=Wdata[7:0];
				if (BE[1])
					RAM[add][15:8]=Wdata[15:8];
				if (BE[2])
					RAM[add][23:16]=Wdata[23:16];
				if (BE[3])
					RAM[add][31:24]=Wdata[31:24];
				$display("%d@%h: *%h <= %h",$time,Pc,{{20{1'b0}},add,2'b00},RAM[add]);
			end
	end
	assign Rdata=RAM[add];

endmodule





