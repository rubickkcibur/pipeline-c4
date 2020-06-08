`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:09:28 12/17/2018 
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
module mips(
    input clk,
    input reset
    );
	wire [31:0]PrRD;
	wire [5:0]HWInt;
	wire [31:0]PrAddr;
	wire [31:0]PrWD;
	wire DMLD;
	wire [3:0]PrBE;
	wire [31:0]PC_MEM;
	
	cpu cpu1(
		.reset(reset),
		.clk(clk),
		.RD_Brige(PrRD),
		.HWInt(HWInt),
		.AO_MEM(PrAddr),
		.Wdata(PrWD),
		.DMLD(DMLD),
		.BE(PrBE),
		.Pc_MEM(PC_MEM)
		);
	
	wire [31:0]RD_DM;
	wire [31:0]RD_Timer1;
	wire [31:0]RD_Timer2;
	wire IRQ1;
	wire IRQ2;
	wire [31:0]PC;
	wire [3:0]BE;
	wire DM_WE;
	wire Timer1_WE;
	wire Timer2_WE;
	wire [31:0]Add;
	wire [31:0]WD;
	
	Bridge Bridge1(
		.PrAddr(PrAddr),
		.PrBE(PrBE),
		.PrWD(PrWD),
		.PrWE(~DMLD),
		.RD_DM(RD_DM),
		.RD_Timer1(RD_Timer1),
		.RD_Timer2(RD_Timer2),
		.PC_MEM(PC_MEM),
		.IRQ1(IRQ1),
		.IRQ2(IRQ2),
		.PC(PC),
		.BE(BE),
		.DM_WE(DM_WE),
		.Timer1_WE(Timer1_WE),
		.Timer2_WE(Timer2_WE),
		.PrRD(PrRD),
		.HWInt(HWInt),
		.Add(Add),
		.WD(WD)
		);
		
	DM DM1(
		.Address(Add),
		.Wdata(WD),
		.Reset(reset),
		.Clk(clk),
		.DMld(~DM_WE),
		.BE(BE),
		.Pc(PC),
		.Rdata(RD_DM)
		);
		
	Timer Timer1(
		.CLK_I(clk),
		.RST_I(reset),
		.address(Add),
		.WE_I(Timer1_WE),
		.DAT_I(WD),
		.DAT_O(RD_Timer1),
		.IRQ(IRQ1)
		);
	
	Timer Timer2(
		.CLK_I(clk),
		.RST_I(reset),
		.address(Add),
		.WE_I(Timer2_WE),
		.DAT_I(WD),
		.DAT_O(RD_Timer2),
		.IRQ(IRQ2)
		);

endmodule
