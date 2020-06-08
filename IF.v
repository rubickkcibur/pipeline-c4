`timescale 1ns / 1ps
`define isdelay (MUX_PCsel!=0)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:09 11/23/2018 
// Design Name: 
// Module Name:    IF 
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
module IF(
    input [31:0] Pc_add_4,
    input [31:0] B_pc,
    input [31:0] J_pc,
    input [31:0] RD1,
	 input [31:0]EPC,
	 input MUX_EXPCsel,
	 input Zero,
    input [2:0] MUX_PCsel,
    input Reset,
    input Clk,
    input Enable,
    output [31:0] Pc,
    output [31:0] Instr,
	 output [4:0]exccode,
	 output delay
    );
	 wire [31:0] npc;
	 wire nop;
	 wire [31:0]orign_In;
	MUX_PC MUX_PC1(
		.Pc_add_4(Pc_add_4),
		.B_pc(B_pc),
		.J_pc(J_pc),
		.RD1(RD1),
		.EPC(EPC),
		.MUX_PCsel(MUX_PCsel),
		.Npc(npc)
		);
	
	PC PC1(
		.Npc(npc),
		.IntReq(MUX_EXPCsel),
		.Reset(Reset),
		.Clk(Clk),
		.Enable(Enable),
		.Pc(Pc)
		);
	
	IF_Exception IF_Exception1(
		.PC(Pc),
		.nop(nop),
		.exccode(exccode)
		);
	
	ROM ROM1(
		.Pc(Pc),
		.Instr(orign_In)
		);
	
	MUX_Instr MUX_Instr1(
		.Instr(orign_In),
		.sel(nop),
		.out(Instr)
		);
	assign delay=`isdelay;
endmodule
