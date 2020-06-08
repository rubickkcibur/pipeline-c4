`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:26 11/23/2018 
// Design Name: 
// Module Name:    J_PC 
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
module J_PC(
    input [31:0] Pc,
    input [25:0] Instr_index,
    output [31:0] J_pc
    );
	assign J_pc={Pc[31:28],Instr_index,2'b00};

endmodule
