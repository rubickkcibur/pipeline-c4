`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:23:41 12/17/2018 
// Design Name: 
// Module Name:    MFEPCM 
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
module MFEPCM(
    input [31:0] EPC_CP0,
    input [31:0] EPC_R,
    input sel,
    output [31:0] EPC
    );
	assign EPC=sel?{EPC_R[31:2],2'b00}:{EPC_CP0[31:2],2'b00};

endmodule
