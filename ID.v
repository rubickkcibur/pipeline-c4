`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:24 11/23/2018 
// Design Name: 
// Module Name:    ID 
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
module ID(
    input [31:0] Pc,
    input [31:0] Instr,
    input [4:0] WA,
    input Enable,
    input Clk,
    input Reset,
	 input IntReq,
	 input Estall,
    input WE,
    input [1:0] EXTsel,
	 input [2:0] bcp,
	 input [31:0]EPC,
	 input [31:0]PC_EX_8,
	 input [31:0]AO_MEM,
	 input [31:0]PC_MEM_8,
	 input [31:0]MUX_WD,
	 input [31:0]PC_WB_8,
	 input [31:0]HI_MEM,
	 input [31:0]LO_MEM,
	 input [31:0]HI_WB,
	 input [31:0]LO_WB,
	 input [3:0]MFRSDsel,
	 input [3:0]MFRTDsel,
	 input [31:0]Pc_WB,
	 input [4:0]exccode,
	 input delay,
	 output [31:0] B_pc,
	 output Zero,
	 output delay_ID,
	 output [31:0] J_pc,
    output [31:0] MFRSDout,
    output [31:0] MFRTDout,
    output [31:0] EXTOut,
    output [31:0] Pc_ID,
    output [31:0] Instr_ID,
	 output [31:0] orign_In_D,
	 output [4:0] exccode_ID,
	 output nop
    );
	wire [31:0] Pc_add_4;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [15:0] imi;
	wire [25:0] instr_index;
	wire [31:0]RD1;
	wire [31:0]RD2;
	wire [4:0]E1;
	wire [4:0]E2;
	
	assign Pc_add_4=Pc_ID+4;
	assign rs=Instr_ID[25:21];
	assign rt=Instr_ID[20:16];
	assign imi=Instr_ID[15:0];
	assign instr_index=Instr_ID[25:0];
	
	IF_ID_REG IF_ID_REG1(
		.Pc(Pc),
		.EPC(EPC),
		.Instr(Instr),
		.Pc_ID(Pc_ID),
		.Instr_ID(orign_In_D),
		.delay(delay),
		.exccode(exccode),
		.Enable(Enable),
		.Clk(Clk),
		.Reset(Reset|IntReq),
		.Estall(Estall),
		.exccode_ID(E1),
		.delay_ID(delay_ID)
		);
		
	ID_Exception ID_Exception1(
		.Instr(orign_In_D),
		.nop(nop),
		.exccode(E2)
		);
	
	Esort Esort1(
		.E1(E1),
		.E2(E2),
		.Eout(exccode_ID)
		);
	
	MUX_Instr MUX_Instr2(
		.Instr(orign_In_D),
		.sel(nop),
		.out(Instr_ID)
		);
	
	GRF GRF1(
		.RA1(rs),
		.RA2(rt),
		.WA(WA),
		.Wdata(MUX_WD),
		.WE(WE),
		.Clk(Clk),
		.Reset(Reset),
		.Rdata1(RD1),
		.Rdata2(RD2),
		.Pc(Pc_WB)
		);
	
	MFRSD MFRSD1(
		.RD1(RD1),
		.PC_EX_8(PC_EX_8),
		.AO_MEM(AO_MEM),
		.PC_MEM_8(PC_MEM_8),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRSDsel(MFRSDsel),
		.MFRSDout(MFRSDout)
		);
	
	MFRTD MFRTD1(
		.RD2(RD2),
		.PC_EX_8(PC_EX_8),
		.AO_MEM(AO_MEM),
		.PC_MEM_8(PC_MEM_8),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRTDsel(MFRTDsel),
		.MFRTDout(MFRTDout)
		);
		
	EXT EXT1(
		.In(imi),
		.EXTsel(EXTsel),
		.EXTOut(EXTOut)
		);
		
	COMP COMP1(
		.RD1(MFRSDout),
		.RD2(MFRTDout),
		.bcp(bcp),
		.Zero(Zero)
		);
		
	B_PC B_PC1(
		.Pc_add_4(Pc_add_4),
		.EXToff(EXTOut),
		.Zero(Zero),
		.B_pc(B_pc)
		);
		
	J_PC J_PC1(
		.Pc(Pc_ID),
		.Instr_index(instr_index),
		.J_pc(J_pc)
		);

endmodule
