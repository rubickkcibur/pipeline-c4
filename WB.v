`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:18:38 11/24/2018 
// Design Name: 
// Module Name:    WB 
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
module WB(
    input [31:0] RD_MEM,
    input [31:0] AO_MEM,
    input [31:0] Instr_MEM,
    input [31:0] Pc_MEM,
	 input [31:0] HI_MEM,
	 input [31:0] LO_MEM,
    input Clk,
    input Reset,
	 input [1:0]MUX_WAsel,
	 input [2:0]MUX_WDsel,
	 input [2:0]loadsel,
	 input [31:0]cp0,
    output [4:0] WA,
    output [31:0] MUX_WD,
	 output [31:0]Instr_WB,
	 output [31:0]Pc_WB,
	 output [31:0]PC_WB_8,
	 output [31:0]HI_WB,
	 output [31:0]LO_WB
		);
	 wire [31:0]RD_WB;
	 wire [31:0]AO_WB;
	 wire [31:0]loadout;
	 wire [31:0]cp0_WB;
	 
	MEM_WB_REG MEM_WB_REG1(
		.RD_MEM(RD_MEM),
		.AO_MEM(AO_MEM),
		.Instr_MEM(Instr_MEM),
		.Pc_MEM(Pc_MEM),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.cp0(cp0),
		.Clk(Clk),
		.Reset(Reset),
		.RD_WB(RD_WB),
		.AO_WB(AO_WB),
		.Instr_WB(Instr_WB),
		.Pc_WB(Pc_WB),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.cp0_WB(cp0_WB)
		);
	
	
	MUX_WA MUX_WA1(
		.Instr_WB(Instr_WB),
		.MUX_WAsel(MUX_WAsel),
		.MUX_WAout(WA)
		);
		
	Load_ext Load_ext1(
		.address(AO_WB),
		.Rdata(RD_WB),
		.loadsel(loadsel),
		.out(loadout)
		);
	
	MUX_WD MUX_WD1(
		.AO_WB(AO_WB),
		.RD_WB(loadout),
		.Instr_WB(Instr_WB),
		.Pc_WB(Pc_WB),
		.hi(HI_WB),
		.lo(LO_WB),
		.cp0(cp0_WB),
		.MUX_WDsel(MUX_WDsel),
		.MUX_WDout(MUX_WD)
		);
	
	assign PC_WB_8=Pc_WB+8;
endmodule
