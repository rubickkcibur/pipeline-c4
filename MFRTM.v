`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:03 11/24/2018 
// Design Name: 
// Module Name:    MFRTM 
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
module MFRTM(
    input [31:0] RT_MEM,
    input [31:0] MUX_WD,
    input [31:0] PC_WB_8,
    input [2:0] MFRTMsel,
	 input [31:0]HI_WB,
	 input [31:0]LO_WB,
    output reg [31:0] MFRTMout
    );
	always @(*)begin
		case (MFRTMsel)
			3'b000: MFRTMout<=RT_MEM;
			3'b001: MFRTMout<=MUX_WD;
			3'b010: MFRTMout<=PC_WB_8;
			3'b011: MFRTMout<=HI_WB;
			3'b100: MFRTMout<=LO_WB;
		endcase
	end

endmodule
