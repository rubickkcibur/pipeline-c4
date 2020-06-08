`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:47:25 12/15/2018 
// Design Name: 
// Module Name:    IF_Exception 
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
module IF_Exception(
    input [31:0] PC,
    output nop,
    output [4:0] exccode
    );
	assign nop=(PC<32'h00003000 || PC>=32'h00005000 || PC[1:0]!=0);
	assign exccode=(PC<32'h00003000 || PC>=32'h00005000 || PC[1:0]!=0)?4:0;

endmodule
