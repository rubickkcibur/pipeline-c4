`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:13 11/23/2018 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] Npc,
	 input IntReq,
	 input Clk,
	 input Reset,
	 input Enable,
    output reg [31:0] Pc
    );
	initial begin
		Pc<=32'h00003000;
	end
	always @(posedge Clk)begin
		if (Reset)
			Pc<=32'h00003000;
		else if (IntReq)
			Pc<=32'h00004180;
		else if(Enable)
			Pc<=Npc;
	end

endmodule
