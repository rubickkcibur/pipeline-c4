`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:30:56 11/24/2018 
// Design Name: 
// Module Name:    MFRSD 
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
module MFRSD(
    input [31:0] RD1,
    input [31:0] PC_EX_8,
    input [31:0] AO_MEM,
    input [31:0] PC_MEM_8,
    input [31:0] MUX_WD,
    input [31:0] PC_WB_8,
	 input [31:0] HI_MEM,
	 input [31:0] LO_MEM,
	 input [31:0] HI_WB,
	 input [31:0] LO_WB,
    input [3:0] MFRSDsel,
    output reg [31:0] MFRSDout
    );
	always @(*)begin
		case (MFRSDsel)
			4'b0000: MFRSDout<=RD1;
			4'b0001: MFRSDout<=PC_EX_8;
			4'b0010: MFRSDout<=AO_MEM;
			4'b0011: MFRSDout<=PC_MEM_8;
			4'b0100: MFRSDout<=MUX_WD;
			4'b0101: MFRSDout<=PC_WB_8;
			4'b0110: MFRSDout<=HI_MEM;
			4'b0111: MFRSDout<=LO_MEM;
			4'b1000: MFRSDout<=HI_WB;
			4'b1001: MFRSDout<=LO_WB;
		endcase
	end

endmodule
