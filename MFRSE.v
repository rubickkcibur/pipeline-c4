`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:03 11/24/2018 
// Design Name: 
// Module Name:    MFRSE 
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
module MFRSE(
    input [31:0] RS_EX,
    input [31:0] AO_MEM,
    input [31:0] PC_MEM_8,
    input [31:0] MUX_WD,
    input [31:0] PC_WB_8,
	 input [31:0] HI_MEM,
	 input [31:0] LO_MEM,
	 input [31:0] HI_WB,
	 input [31:0] LO_WB,
    input [3:0] MFRSEsel,
    output reg [31:0] MFRSEout
    );
	always @(*)begin
		case (MFRSEsel)
			4'b0000: MFRSEout<=RS_EX;
			4'b0001: MFRSEout<=AO_MEM;
			4'b0010: MFRSEout<=PC_MEM_8;
			4'b0011: MFRSEout<=MUX_WD;
			4'b0100: MFRSEout<=PC_WB_8;
			4'b0101: MFRSEout<=HI_MEM;
			4'b0110: MFRSEout<=LO_MEM;
			4'b0111: MFRSEout<=HI_WB;
			4'b1000: MFRSEout<=LO_WB;
		endcase
	end

endmodule
