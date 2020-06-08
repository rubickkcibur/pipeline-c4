`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:03 11/23/2018 
// Design Name: 
// Module Name:    mips 
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
module cpu(
    input reset,
    input clk,
	 input [31:0]RD_Brige,//
	 input [5:0]HWInt,//
    output [31:0] AO_MEM,//
	 output [31:0]Wdata,//
	 output DMLD,//
	 output [3:0] BE,//
    output [31:0] Pc_MEM//
    );
	 
	 wire [31:0]Pc;
	 wire [31:0]Pc_add_4=Pc+4;
	 wire [31:0]B_pc;
	 wire [31:0]J_pc;
	 wire [31:0]MFRSDout;
	 wire [2:0]MUX_PCsel;
	 wire Enable_IF;
	 wire [31:0]Instr;
	 wire [31:0]EPC;
	 wire [4:0]exccode;
	 wire delay;
	 wire Zero;
	 wire IntReq;
	
	IF IF1(
		.Pc_add_4(Pc_add_4),
		.B_pc(B_pc),
		.J_pc(J_pc),
		.RD1(MFRSDout),
		.EPC(EPC),
		.MUX_EXPCsel(IntReq),
		.MUX_PCsel(MUX_PCsel),
		.Zero(Zero),
		.Reset(reset),
		.Clk(clk),
		.Enable(Enable_IF),
		.Pc(Pc),
		.Instr(Instr),
		.exccode(exccode),
		.delay(delay)
		);
		

    wire [4:0] WA;
    wire Enable_ID;
    wire WE;
    wire [1:0] EXTsel;
	 wire [2:0] bcp;
	 wire [31:0]PC_EX_8;
	 wire [31:0]PC_MEM_8;
	 wire [31:0]MUX_WD;
	 wire [31:0]PC_WB_8;
	 wire [3:0]MFRSDsel;
	 wire [3:0]MFRTDsel;
    wire [31:0] MFRTDout;
    wire [31:0] EXTOut;
    wire [31:0] Pc_ID;
    wire [31:0] Instr_ID;
	 wire [31:0]Pc_WB;
	 wire [31:0]HI_MEM;
	 wire [31:0]LO_MEM;
	 wire [31:0]HI_WB;
	 wire [31:0]LO_WB;
	 wire delay_ID;
	 wire [4:0]exccode_ID;
	 wire Estall=(Instr_ID[31:26]==6'b010000)&(Instr_ID[5:0]==6'b011000)&~Reset_EX;
	 wire [31:0]orign_In_D;
	 wire nop_ID;
	 
	 ID ID1(
		.Pc(Pc),
		.Instr(Instr),
		.WA(WA),
		.Enable(Enable_ID),
		.Clk(clk),
		.Reset(reset),
		.IntReq(IntReq),
		.Estall(Estall),
		.WE(WE),
		.EPC(EPC),
		.EXTsel(EXTsel),
		.bcp(bcp),
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
		.MFRTDsel(MFRTDsel),
		.Pc_WB(Pc_WB),
		.exccode(exccode),
		.delay(delay),
		.B_pc(B_pc),
		.Zero(Zero),
		.delay_ID(delay_ID),
		.exccode_ID(exccode_ID),
		.J_pc(J_pc),
		.MFRSDout(MFRSDout),
		.MFRTDout(MFRTDout),
		.EXTOut(EXTOut),
		.Pc_ID(Pc_ID),
		.Instr_ID(Instr_ID),
		.orign_In_D(orign_In_D),
		.nop(nop_ID)
		);
	
	ID_Controller ID_Controller1(
		.Instr_ID(orign_In_D),
		.EXTsel(EXTsel),
		.MUX_PCsel(MUX_PCsel),
		.bcp(bcp)
		);
		
    wire MUX_ALU_Bsel;
	 wire MUX_ALU_Asel;
	 wire [2:0]M_Dsel;
    wire [3:0] ALUop;
	 wire [3:0]MFRSEsel;
	 wire [3:0]MFRTEsel;
    wire [31:0] C;
    wire [31:0] Pc_EX;
    wire [31:0] Instr_EX;
    wire [31:0] MFRTEout;
	 wire Reset_EX;
	 wire Busy;
	 wire start;
	 wire [31:0]HI;
	 wire [31:0]LO;
	 wire delay_EX;
	 wire [4:0]exccode_EX;
	 wire [31:0]orign_In_E;
	 wire nop_EX;
	 wire remthi;
	 wire remtlo;
	 
	 EX EX1(
		.MFRSD(MFRSDout),
		.MFRTD(MFRTDout),
		.EXT(EXTOut),
		.Pc_ID(Pc_ID),
		.Instr_ID(Instr_ID),
		.Clk(clk),
		.Reset(reset|IntReq|Reset_EX),
		.IntReq(IntReq),
		.remthi(remthi),
		.remtlo(remtlo),
		.M_Dreset(reset),
		.MUX_ALU_Asel(MUX_ALU_Asel),
		.MUX_ALU_Bsel(MUX_ALU_Bsel),
		.M_Dsel(M_Dsel),
		.ALUop(ALUop),
		.AO_MEM(AO_MEM),
		.PC_MEM_8(PC_MEM_8),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRSEsel(MFRSEsel),
		.MFRTEsel(MFRTEsel),
		.exccode_ID(exccode_ID),
		.delay_ID(delay_ID),
		.C(C),
		.Pc_EX(Pc_EX),
		.Instr_EX(Instr_EX),
		.orign_In_E(orign_In_E),
		.MFRTEout(MFRTEout),
		.PC_EX_8(PC_EX_8),
		.Busy(Busy),
		.start(start),
		.HI(HI),
		.LO(LO),
		.exccode_EX(exccode_EX),
		.delay_EX(delay_EX),
		.nop(nop_EX)
		);
		
	EX_Controller EX_Controller1(
		.Instr_EX(orign_In_E),
		.M_Dsel(M_Dsel),
		.MUX_ALU_Asel(MUX_ALU_Asel),
		.MUX_ALU_Bsel(MUX_ALU_Bsel),
		.ALUop(ALUop)
		);
		
    wire DMld;
	 wire [2:0]MFRTMsel;
    wire [31:0] Rdata;
    wire [31:0] Instr_MEM;
	 wire [1:0]BEsel;
	 wire [1:0]Wdata_producesel;
	 wire delay_MEM;
	 wire [4:0]exccode_MEM;
	 wire [31:0]MFRTMout;
	 wire [31:0]orign_In_M;
	 wire nop_MEM;
	 
	 MEM MEM1(
		.ALUout(C),
		.MFRTE(MFRTEout),
		.Pc_EX(Pc_EX),
		.Instr_EX(Instr_EX),
		.HI(HI),
		.LO(LO),
		.Clk(clk),
		.Reset(reset),
		.IntReq(IntReq),
		.DMld(DMld|IntReq),
		.BEsel(BEsel),
		.Wdata_producesel(Wdata_producesel),
		.MUX_WD(MUX_WD),
		.PC_WB_8(PC_WB_8),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB),
		.MFRTMsel(MFRTMsel),
		.exccode(exccode_EX),
		.delay_EX(delay_EX),
		.RD_Brige(RD_Brige),//
		.AO_MEM(AO_MEM),//
		.Wdata(Wdata),//
		.DMLD(DMLD),//
		.BE(BE),//
		.Rdata(Rdata),
		.Pc_MEM(Pc_MEM),//
		.Instr_MEM(Instr_MEM),
		.orign_In_M(orign_In_M),
		.PC_MEM_8(PC_MEM_8),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.exccode_MEM(exccode_MEM),
		.delay_MEM(delay_MEM),
		.MFRTMout(MFRTMout),
		.nop(nop_MEM)
		);
		
	 remt remt1(
		.Instr_MEM(orign_In_M),
		.IntReq(IntReq),
		.remthi(remthi),
		.remtlo(remtlo)
		);
	
	 wire CP0WE;
	 wire EXLClr;
	 MEM_Controller MEM_Controller1(
		.Instr_MEM(orign_In_M),
		.DMld(DMld),
		.BEsel(BEsel),
		.Wdata_producesel(Wdata_producesel),
		.CP0WE(CP0WE),
		.EXLClr(EXLClr)
		);
		
	 wire [4:0]CP0add=Instr_MEM[15:11];

	 wire [31:0]CP0out;
	 wire [31:0]EPC_CP0;
	 
	 CP0 CP01(
		.RA(CP0add),
		.WA(CP0add),
		.WD(MFRTMout),
		.PC(Pc_MEM),
		.ExcCode(exccode_MEM),
		.HWInt(HWInt),
		.delay(delay_MEM),
		.WE(CP0WE),
		.EXLClr(EXLClr),
		.clk(clk),
		.reset(reset),
		.IntReq(IntReq),
		.EPC(EPC_CP0),
		.RD(CP0out)
		);
		
	 MFEPCM MFEPCM1(
		.EPC_CP0(EPC_CP0),
		.EPC_R(MFRTMout),
		.sel((CP0add==5'b01110)&CP0WE),
		.EPC(EPC)
		);
	
	 wire [1:0]MUX_WAsel;
	 wire [2:0]MUX_WDsel;
	 wire [31:0]Instr_WB;
	 wire [2:0] load_extsel;
	 
	 WB WB1(
		.AO_MEM(AO_MEM),
		.RD_MEM(Rdata),
		.Pc_MEM(Pc_MEM),
		.Instr_MEM(Instr_MEM),
		.HI_MEM(HI_MEM),
		.LO_MEM(LO_MEM),
		.cp0(CP0out),
		.Clk(clk),
		.Reset(reset|IntReq),
		.loadsel(load_extsel),
		.MUX_WAsel(MUX_WAsel),
		.MUX_WDsel(MUX_WDsel),
		.WA(WA),
		.MUX_WD(MUX_WD),
		.Instr_WB(Instr_WB),
		.Pc_WB(Pc_WB),
		.PC_WB_8(PC_WB_8),
		.HI_WB(HI_WB),
		.LO_WB(LO_WB)
		);
	
	 WB_Controller WB_Controller1(
		.Instr_WB(Instr_WB),
		.Load_extsel(load_extsel),
		.MUX_WAsel(MUX_WAsel),
		.MUX_WDsel(MUX_WDsel),
		.WE(WE)
		);
	 
	 Installer Installer1(
		.Instr_ID(Instr_ID),
		.Instr_EX(Instr_EX),
		.Instr_MEM(Instr_MEM),
		.Busy_start(Busy|start),
		.Enable_PC(Enable_IF),
		.Enable_IF_ID(Enable_ID),
		.Reset_ID_EX(Reset_EX)
		);

	 Forwarding Forwarding1(
		.Instr_ID(orign_In_D),
		.Instr_EX(orign_In_E),
		.Instr_MEM(orign_In_M),
		.Instr_WB(Instr_WB),
		.MFRSDsel(MFRSDsel),
		.MFRTDsel(MFRTDsel),
		.MFRSEsel(MFRSEsel),
		.MFRTEsel(MFRTEsel),
		.MFRTMsel(MFRTMsel)
		);

endmodule
