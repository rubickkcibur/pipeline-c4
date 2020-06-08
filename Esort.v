`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:14 12/16/2018 
// Design Name: 
// Module Name:    Esort 
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
module Esort(
    input [4:0] E1,
    input [4:0] E2,
    output [4:0] Eout
    );
	assign Eout=E1?E1:E2;

endmodule
