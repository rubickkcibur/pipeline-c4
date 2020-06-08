`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:12:32 11/23/2018 
// Design Name: 
// Module Name:    MUX_ALU_B 
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
module MUX_ALU_B(
    input [31:0] RT,
    input [31:0] EXT,
    input MUX_ALU_Bsel,
    output [31:0] B
    );
	assign B=(MUX_ALU_Bsel)?EXT:RT;

endmodule
