`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:08 11/23/2018 
// Design Name: 
// Module Name:    MUX_PC 
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
module MUX_PC(
    input [31:0] Pc_add_4,
    input [31:0] B_pc,
    input [31:0] J_pc,
    input [31:0] RD1,
	 input [31:0] EPC,
    input [2:0] MUX_PCsel,
    output reg [31:0] Npc
    );
	always @(*)begin
		case (MUX_PCsel)
			3'b000: Npc<=Pc_add_4;
			3'b001: Npc<=B_pc;
			3'b010: Npc<=J_pc;
			3'b011: Npc<=RD1;
			3'b100: Npc<=EPC;
		endcase
	end

endmodule
