`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:55 12/18/2018 
// Design Name: 
// Module Name:    remt 
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
module remt(
    input [31:0] Instr_MEM,
    input IntReq,
    output remthi,
    output remtlo
    );
	wire [5:0]op=Instr_MEM[31:26];
	wire [5:0]func=Instr_MEM[5:0];
	assign remthi=(op==6'b000000)&&(func==6'b010001)&&IntReq;
	assign remtlo=(op==6'b000000)&&(func==6'b010011)&&IntReq;

endmodule
