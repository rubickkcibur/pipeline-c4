`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:02 12/08/2018 
// Design Name: 
// Module Name:    MUX_ALU_A 
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
module MUX_ALU_A(
    input [31:0] MFRSE,
    input [4:0] s,
    input MUX_ALU_Asel,
    output [31:0] ALU_A
    );
	assign ALU_A=MUX_ALU_Asel?{27'b0000_0000_0000_0000_0000_0000_000,s}:MFRSE;

endmodule
