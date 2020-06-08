`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:33:25 11/24/2018 
// Design Name: 
// Module Name:    EX_MEM_REG 
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
module EX_MEM_REG(
    input [31:0] ALUout,
    input [31:0] MFRTE,
    input [31:0] Instr_EX,
    input [31:0] Pc_EX,
	 input [4:0]exccode_EX,
	 input delay_EX,
	 input [31:0] hi,
	 input [31:0] lo,
    input Clk,
    input Reset,
    output reg [31:0] AO_MEM,
    output reg [31:0] RT_MEM,
    output reg [31:0] Instr_MEM,
    output reg [31:0] Pc_MEM,
	 output reg [31:0] HI_MEM,
	 output reg [31:0] LO_MEM,
	 output reg [4:0]exccode_MEM,
	 output reg delay_MEM
    );
	 
	 initial begin
		AO_MEM<=0;
		RT_MEM<=0;
		Instr_MEM<=0;
		Pc_MEM<=32'h00003000;
		HI_MEM<=0;
		LO_MEM<=0;
		exccode_MEM<=0;
		delay_MEM<=0;
		end
		
	always @(posedge Clk)begin
		if (Reset)begin
			AO_MEM<=0;
			RT_MEM<=0;
			Instr_MEM<=0;
			Pc_MEM<=Pc_EX;
			HI_MEM<=0;
			LO_MEM<=0;
			exccode_MEM<=0;
			delay_MEM<=0;
		end
		else begin
			AO_MEM<=ALUout;
			RT_MEM<=MFRTE;
			Instr_MEM<=Instr_EX;
			Pc_MEM<=Pc_EX;
			HI_MEM<=hi;
			LO_MEM<=lo;
			exccode_MEM<=exccode_EX;
			delay_MEM<=delay_EX;
		end
	end
	

endmodule
