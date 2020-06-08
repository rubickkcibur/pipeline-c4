`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:12:38 11/24/2018 
// Design Name: 
// Module Name:    MEM_WB_REG 
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
module MEM_WB_REG(
    input [31:0] RD_MEM,
    input [31:0] AO_MEM,
    input [31:0] Instr_MEM,
    input [31:0] Pc_MEM,
	 input [31:0] HI_MEM,
	 input [31:0] LO_MEM,
	 input [31:0]cp0,
    input Clk,
    input Reset,
    output reg[31:0] RD_WB,
    output reg[31:0] AO_WB,
    output reg[31:0] Instr_WB,
    output reg[31:0] Pc_WB,
	 output reg[31:0] HI_WB,
	 output reg[31:0] LO_WB,
	 output reg[31:0]	cp0_WB
    );
	 
	 initial begin
		RD_WB<=0;
		AO_WB<=0;
		Instr_WB<=0;
		Pc_WB<=32'h00003000;
		HI_WB<=0;
		LO_WB<=0;
		cp0_WB<=0;
		end
		
	always @(posedge Clk)begin
		if (Reset)begin
			RD_WB<=0;
			AO_WB<=0;
			Instr_WB<=0;
			Pc_WB<=Pc_MEM;
			HI_WB<=0;
			LO_WB<=0;
			cp0_WB<=0;
		end
		else begin
			RD_WB<=RD_MEM;
			AO_WB<=AO_MEM;
			Instr_WB<=Instr_MEM;
			Pc_WB<=Pc_MEM;
			HI_WB<=HI_MEM;
			LO_WB<=LO_MEM;
			cp0_WB<=cp0;
		end
	end

endmodule
