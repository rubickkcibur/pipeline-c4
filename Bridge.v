`timescale 1ns / 1ps
`define isDM (PrAddr<=32'h00002fff)
`define isTimer1 (PrAddr>=32'h00007f00 && PrAddr<=32'h00007f0b)
`define isTimer2 (PrAddr>=32'h00007f10 && PrAddr<=32'h00007f1b)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:46 12/14/2018 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input [31:0] PrAddr,
    input [3:0] PrBE,
    input [31:0] PrWD,
    input PrWE,
    input [31:0] RD_DM,
    input [31:0] RD_Timer1,
    input [31:0] RD_Timer2,
	 input [31:0] PC_MEM,
	 input IRQ1,
	 inout IRQ2,
	 output [31:0]PC,
	 output [3:0]BE,
	 output DM_WE,
	 output Timer1_WE,
	 output Timer2_WE,
    output [31:0] PrRD,
    output [5:0] HWInt,
    output [31:0] Add,
    output [31:0] WD
    );
	assign DM_WE=(`isDM)&PrWE;
	assign Timer1_WE=(`isTimer1)&PrWE;
	assign Timer2_WE=(`isTimer2)&PrWE;
	assign BE=PrBE;
	assign PC=PC_MEM;
	assign Add=PrAddr;
	assign WD=PrWD;
	assign PrRD=`isDM?RD_DM:
					`isTimer1?RD_Timer1:
					`isTimer2?RD_Timer2:0;
	assign HWInt[0]=IRQ1;
	assign HWInt[1]=IRQ2;
	assign HWInt[5:2]=0;

endmodule
