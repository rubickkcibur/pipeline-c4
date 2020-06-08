`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:43:35 12/15/2018 
// Design Name: 
// Module Name:    MUX_Instr 
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
module MUX_Instr(
    input [31:0] Instr,
    input sel,
    output [31:0] out
    );
	assign out=sel?0:Instr;

endmodule
