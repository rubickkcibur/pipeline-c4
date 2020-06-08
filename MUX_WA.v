`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:46 11/24/2018 
// Design Name: 
// Module Name:    MUX_WA 
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
module MUX_WA(
    input [31:0] Instr_WB,
    input [1:0] MUX_WAsel,
    output reg [4:0] MUX_WAout
    );
	wire [4:0]rd;
	wire [4:0]rt;
	
	assign rd=Instr_WB[15:11];
	assign rt=Instr_WB[20:16];
	
	always @(*)begin
		case (MUX_WAsel)
			2'b00: MUX_WAout<=rd;
			2'b01: MUX_WAout<=rt;
			2'b10: MUX_WAout<=5'b11111;
		endcase
	end

endmodule
