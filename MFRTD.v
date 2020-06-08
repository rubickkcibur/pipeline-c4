`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:34:04 11/24/2018 
// Design Name: 
// Module Name:    MFRTD 
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
module MFRTD(
    input [31:0] RD2,
    input [31:0] PC_EX_8,
    input [31:0] AO_MEM,
    input [31:0] PC_MEM_8,
    input [31:0] MUX_WD,
    input [31:0] PC_WB_8,
	 input [31:0] HI_MEM,
	 input [31:0] LO_MEM,
	 input [31:0] HI_WB,
	 input [31:0] LO_WB,
    input [3:0] MFRTDsel,
    output reg [31:0] MFRTDout
    );
	always @(*)begin
		case (MFRTDsel)
			4'b0000: MFRTDout<=RD2;
			4'b0001: MFRTDout<=PC_EX_8;
			4'b0010: MFRTDout<=AO_MEM;
			4'b0011: MFRTDout<=PC_MEM_8;
			4'b0100: MFRTDout<=MUX_WD;
			4'b0101: MFRTDout<=PC_WB_8;
			4'b0110: MFRTDout<=HI_MEM;
			4'b0111: MFRTDout<=LO_MEM;
			4'b1000: MFRTDout<=HI_WB;
			4'b1001: MFRTDout<=LO_WB;
		endcase
	end

endmodule

