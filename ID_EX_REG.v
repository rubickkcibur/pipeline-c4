`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:25 11/23/2018 
// Design Name: 
// Module Name:    ID_EX_REG 
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
module ID_EX_REG(
    input [31:0] MFRSD,
    input [31:0] MFRTD,
    input [31:0] EXT,
    input [31:0] Pc_ID,
    input [31:0] Instr_ID,
	 input [4:0]exccode_ID,
	 input delay_ID,
    input Reset,
    input Clk,
    output reg[31:0] RS_EX,
    output reg[31:0] RT_EX,
    output reg[31:0] EXT_EX,
    output reg[31:0] Pc_EX,
    output reg[31:0] Instr_EX,
	 output reg[4:0]exccode_EX,
	 output reg delay_EX
    );
	 
	 initial begin
		RS_EX<=0;
		RT_EX<=0;
		EXT_EX<=0;
		Pc_EX<=32'h00003000;
		Instr_EX<=0;
		exccode_EX<=0;
		delay_EX<=0;
		end
		
	always @(posedge Clk)begin
		if (Reset)begin
			RS_EX<=0;
			RT_EX<=0;
			EXT_EX<=0;
			Pc_EX<=Pc_ID;
			Instr_EX<=0;
			exccode_EX<=0;
			delay_EX<=0;
		end
		else begin
			RS_EX<=MFRSD;
			RT_EX<=MFRTD;
			EXT_EX<=EXT;
			Pc_EX<=Pc_ID;
			Instr_EX<=Instr_ID;
			exccode_EX<=exccode_ID;
			delay_EX<=delay_ID;
		end
	end

endmodule
