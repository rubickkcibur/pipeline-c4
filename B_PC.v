`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:21 11/23/2018 
// Design Name: 
// Module Name:    B_PC 
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
module B_PC(
    input [31:0] Pc_add_4,
    input [31:0] EXToff,
    input Zero,
    output [31:0] B_pc
    );
	assign B_pc=(Zero)?(Pc_add_4+(EXToff<<2)):(Pc_add_4+4);

endmodule
