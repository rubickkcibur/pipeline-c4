`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:46:57 11/24/2018 
// Design Name: 
// Module Name:    MEM 
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
module MEM(
    input [31:0] ALUout,
    input [31:0] MFRTE,
    input [31:0] Pc_EX,
    input [31:0] Instr_EX,
	 input [31:0] HI,
	 input [31:0] LO,
    input Clk,
    input Reset,
	 input IntReq,
    input DMld,
	 input [1:0]BEsel,
	 input [31:0]MUX_WD,
	 input [31:0]PC_WB_8,
	 input [31:0]HI_WB,
	 input [31:0]LO_WB,
	 input [2:0]MFRTMsel,
	 input [1:0]Wdata_producesel,
	 input [4:0]exccode,
	 input delay_EX,
	 input [31:0]RD_Brige,//
    output [31:0] AO_MEM,//
	 output [31:0]Wdata,//
	 output DMLD,//
	 output [3:0] BE,//
    output [31:0] Rdata,
    output [31:0] Pc_MEM,//
    output [31:0] Instr_MEM,
	 output [31:0] orign_In_M,
	 output [31:0] PC_MEM_8,
	 output [31:0] HI_MEM,
	 output [31:0] LO_MEM,
	 output [4:0]exccode_MEM,
	 output delay_MEM,
	 output [31:0]MFRTMout,
	 output nop
    );
	 wire [31:0] rt_MEM;
	 wire [4:0]E1;
	 wire [4:0]E2;
	 
	EX_MEM_REG EX_MEM_REG1(
		.ALUout(ALUout),
		.MFRTE(MFRTE),
		.Instr_EX(Instr_EX),
		.Pc_EX(Pc_EX),
		.hi(HI),
		.lo(LO),
		.Clk(Clk),
		.Reset(Reset|IntReq),
		.exccode_EX(exccode),
		.delay_EX(delay_EX),
		.AO_MEM(AO_MEM),
		.RT_MEM(rt_MEM),
		.Instr_MEM(orign_In_M),
		.Pc_MEM(Pc_MEM),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.exccode_MEM(E1),
		.delay_MEM(delay_MEM)
		);
		
	MFRTM MFRTM1(
		.RT_MEM(rt_MEM),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRTMsel(MFRTMsel),
		.MFRTMout(MFRTMout)
		);
	
	BEproduce BEproduce1(
		.address(AO_MEM),
		.BEsel(BEsel),
		.BE(BE)
		);
	
	Wdata_produce Wdata_produce1(
		.MFRTMout(MFRTMout),
		.address(AO_MEM),
		.sel(Wdata_producesel),
		.Wdata(Wdata)
		);
	
	MEM_Exception MEM_Exception1(
		.Instr(orign_In_M),
		.address(AO_MEM),
		.nop(nop),
		.exccode(E2)
		);
		
	Esort Esort3(
		.E1(E1),
		.E2(E2),
		.Eout(exccode_MEM)
		);
	
	MUX_Instr MUX_Instr4(
		.Instr(orign_In_M),
		.sel(nop),
		.out(Instr_MEM)
		);
	assign PC_MEM_8=Pc_MEM+8;
	assign DMLD=DMld|nop;///
	assign Rdata=RD_Brige;
endmodule
