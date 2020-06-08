`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:38:54 12/16/2018 
// Design Name: 
// Module Name:    MUX_EXPC 
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
module MUX_EXPC(
    input [31:0] NPC,
    input sel,
    output [31:0] RNPC
    );
	assign RNPC=sel?32'h00004180:NPC;

endmodule
