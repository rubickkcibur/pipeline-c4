`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:23 11/24/2018 
// Design Name: 
// Module Name:    MUX_WD 
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
module MUX_WD(
    input [31:0] AO_WB,
    input [31:0] RD_WB,
    input [31:0] Instr_WB,
    input [31:0] Pc_WB,
	 input [31:0] hi,
	 input [31:0] lo,
	 input [31:0] cp0,
    input [2:0] MUX_WDsel,
    output reg [31:0] MUX_WDout
    );
	wire [15:0]imi;
	assign imi=Instr_WB[15:0];
	
	always @(*)begin
		case(MUX_WDsel)
			3'b000: MUX_WDout<=AO_WB;
			3'b001: MUX_WDout<=Pc_WB+8;
			3'b010: MUX_WDout<=RD_WB;
			3'b011: MUX_WDout<=hi;
			3'b100: MUX_WDout<=lo;
			3'b101: MUX_WDout<=cp0;
		endcase
	end

endmodule
