`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:44 11/23/2018 
// Design Name: 
// Module Name:    COMP 
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
module COMP(
    input [31:0] RD1,
    input [31:0] RD2,
	 input [2:0] bcp,
    output reg Zero
    );
	always @(*)begin
		case(bcp)
			3'b000: Zero<=(RD1==RD2);
			3'b001: Zero<=(RD1!=RD2);
			3'b010: Zero<=($signed(RD1)<=0);
			3'b011: Zero<=($signed(RD1)>0);
			3'b100: Zero<=($signed(RD1)<0);
			3'b101: Zero<=($signed(RD1)>=0);
		endcase
	end

endmodule
