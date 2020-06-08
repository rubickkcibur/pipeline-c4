`timescale 1ns / 1ps
`define mult ((Instr_EX[31:26]==6'b000000)&&(Instr_EX[5:0]==6'b011000))
`define multu ((Instr_EX[31:26]==6'b000000)&&(Instr_EX[5:0]==6'b011001))
`define div ((Instr_EX[31:26]==6'b000000)&&(Instr_EX[5:0]==6'b011010))
`define divu ((Instr_EX[31:26]==6'b000000)&&(Instr_EX[5:0]==6'b011011))
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:47:14 11/23/2018 
// Design Name: 
// Module Name:    EX 
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
module EX(
    input [31:0] MFRSD,
    input [31:0] MFRTD,
    input [31:0] EXT,
    input [31:0] Pc_ID,
    input [31:0] Instr_ID,
    input Clk,
    input Reset,
	 input IntReq,
	 input remthi,
	 input remtlo,
	 input M_Dreset,
    input MUX_ALU_Bsel,
	 input MUX_ALU_Asel,
	 input [2:0]M_Dsel,
    input [3:0] ALUop,
	 input [31:0]AO_MEM,
	 input [31:0]PC_MEM_8,
	 input [31:0]MUX_WD,
	 input [31:0]PC_WB_8,
	 input [31:0]HI_MEM,
	 input [31:0]LO_MEM,
	 input [31:0]HI_WB,
	 input [31:0]LO_WB,
	 input [3:0]MFRSEsel,
	 input [3:0]MFRTEsel,
	 input [4:0]exccode_ID,
	 input delay_ID,
    output [31:0] C,
    output [31:0] Pc_EX,
    output [31:0] Instr_EX,
	 output [31:0] orign_In_E,
    output [31:0] MFRTEout,
	 output [31:0] PC_EX_8,
	 output Busy,
	 output start,
	 output [31:0] HI,
	 output [31:0] LO,
	 output [4:0]exccode_EX,
	 output delay_EX,
	 output nop
    );
	wire [31:0]ALU_A;
	wire [31:0]ext;
	wire [31:0]ALU_B;
	wire [31:0]rs_EX;
	wire [31:0]rt_EX;
	wire [31:0]MFRSEout;
	wire [4:0]E1;
	wire [4:0]E2;
	wire Overflow;
	assign start=`mult|`multu|`div|`divu;
	
	ID_EX_REG ID_EX_REG1(
		.MFRSD(MFRSD),
		.MFRTD(MFRTD),
		.EXT(EXT),
		.Pc_ID(Pc_ID),
		.Instr_ID(Instr_ID),
		.Clk(Clk),
		.Reset(Reset),
		.exccode_ID(exccode_ID),
		.delay_ID(delay_ID),
		.RS_EX(rs_EX),
		.RT_EX(rt_EX),
		.EXT_EX(ext),
		.Pc_EX(Pc_EX),
		.Instr_EX(orign_In_E),
		.exccode_EX(E1),
		.delay_EX(delay_EX)
		);
	
	MFRSE MFRSE1(
		.RS_EX(rs_EX),
		.AO_MEM(AO_MEM),
		.PC_MEM_8(PC_MEM_8),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRSEsel(MFRSEsel),
		.MFRSEout(MFRSEout)
		);
	
	MFRTE MFRTE1(
		.RT_EX(rt_EX),
		.AO_MEM(AO_MEM),
		.PC_MEM_8(PC_MEM_8),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRTEsel(MFRTEsel),
		.MFRTEout(MFRTEout)
		);
	
	M_D M_D1(
		.start(start),
		.D1(MFRSEout),
		.D2(MFRTEout),
		.sel(M_Dsel),
		.IntReq(IntReq),
		.remthi(remthi),
		.remtlo(remtlo),
		.clk(Clk),
		.reset(M_Dreset),
		.Busy(Busy),
		.HI(HI),
		.LO(LO)
		);
	
	MUX_ALU_A MUX_ALU_A1(
		.MFRSE(MFRSEout),
		.s(Instr_EX[10:6]),
		.MUX_ALU_Asel(MUX_ALU_Asel),
		.ALU_A(ALU_A)
		);
		
	MUX_ALU_B MUX_ALU_B1(
		.RT(MFRTEout),
		.EXT(ext),
		.MUX_ALU_Bsel(MUX_ALU_Bsel),
		.B(ALU_B)
		);
		
	ALU ALU1(
		.A(ALU_A),
		.B(ALU_B),
		.Op(ALUop),
		.C(C),
		.Overflow(Overflow)
		);
	
	EX_Exception EX_Exception1(
		.Overflow(Overflow),
		.Instr(orign_In_E),
		.nop(nop),
		.exccode(E2)
		);
	
	Esort Esort2(
		.E1(E1),
		.E2(E2),
		.Eout(exccode_EX)
		);
	
	MUX_Instr MUX_Instr3(
		.Instr(orign_In_E),
		.sel(nop),
		.out(Instr_EX)
		);
	assign PC_EX_8=Pc_EX+8;
endmodule
