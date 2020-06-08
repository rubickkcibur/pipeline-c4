`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:01 11/24/2018 
// Design Name: 
// Module Name:    MFRTE 
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
module MFRTE(
    input [31:0] RT_EX,
    input [31:0] AO_MEM,
    input [31:0] PC_MEM_8,
    input [31:0] MUX_WD,
    input [31:0] PC_WB_8,
	 input [31:0] HI_MEM,
	 input [31:0] LO_MEM,
	 input [31:0] HI_WB,
	 input [31:0] LO_WB,
    input [3:0] MFRTEsel,
    output reg [31:0] MFRTEout
    );
	always @(*)begin
		case (MFRTEsel)
			4'b0000: MFRTEout<=RT_EX;
			4'b0001: MFRTEout<=AO_MEM;
			4'b0010: MFRTEout<=PC_MEM_8;
			4'b0011: MFRTEout<=MUX_WD;
			4'b0100: MFRTEout<=PC_WB_8;
			4'b0101: MFRTEout<=HI_MEM;
			4'b0110: MFRTEout<=LO_MEM;
			4'b0111: MFRTEout<=HI_WB;
			4'b1000: MFRTEout<=LO_WB;
		endcase
	end

endmodule
