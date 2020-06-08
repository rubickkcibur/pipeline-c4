`timescale 1ns / 1ps
`define R 6'b000000
`define add 6'b100000
`define addu 6'b100001
`define sub 6'b100010
`define subu 6'b100011
`define sllv 6'b000100
`define srav 6'b000111
`define srlv 6'b000110
`define AND 6'b100100
`define OR 6'b100101
`define XOR 6'b100110
`define NOR 6'b100111
`define slt 6'b101010
`define sltu 6'b101011
`define sll 6'b000000
`define srl 6'b000010
`define sra 6'b000011

`define addi 6'b001000
`define addiu 6'b001001
`define andi 6'b001100
`define ori 6'b001101
`define xori 6'b001110
`define lui 6'b001111
`define slti 6'b001010
`define sltiu 6'b001011

`define beq 6'b000100
`define bne 6'b000101
`define blez 6'b000110
`define bgtz 6'b000111
`define BZ 6'b000001// «bltzªÚ’ﬂbgez
`define bltz 5'b00000
`define bgez 5'b00001

`define j 6'b000010
`define jal 6'b000011
`define jalr 6'b001001
`define jr 6'b001000

`define sw 6'b101011
`define sh 6'b101001
`define sb 6'b101000
`define lw 6'b100011
`define lh 6'b100001
`define lhu 6'b100101
`define lb 6'b100000
`define lbu 6'b100100

`define mult 6'b011000
`define multu 6'b011001
`define div 6'b011010
`define divu 6'b011011
`define mthi 6'b010001
`define mtlo 6'b010011
`define mfhi 6'b010000
`define mflo 6'b010010

`define cop0 6'b010000
`define eret 6'b011000
`define mfc0 5'b00000
`define mtc0 5'b00100

`define In_EX_is_jal (op_EX==`jal)
`define In_EX_is_jalr (op_EX==`R && func_EX==`jalr)

`define In_MEM_is_mfhi (op_MEM==`R && func_MEM==`mfhi)
`define In_MEM_is_mflo (op_MEM==`R && func_MEM==`mflo)
`define In_MEM_is_r (op_MEM==`R && func_MEM!=`jr && func_MEM!=`jalr && func_MEM!=`mfhi && func_MEM!=`mflo)
`define In_MEM_is_i (op_MEM==`addi || op_MEM==`addiu || op_MEM==`andi || op_MEM==`ori || op_MEM==`xori || op_MEM==`lui || op_MEM==`slti || op_MEM==`sltiu)
`define In_MEM_is_jal (op_MEM==`jal)
`define In_MEM_is_jalr (op_MEM==`R && func_MEM==`jalr)

`define In_WB_is_mfhi (op_WB==`R && func_WB==`mfhi)
`define In_WB_is_mflo (op_WB==`R && func_WB==`mflo)
`define In_WB_is_r (op_WB==`R && func_WB!=`jr && func_WB!=`jalr && func_WB!=`mfhi && func_WB!=`mflo)
`define In_WB_is_i (op_WB==`addi || op_WB==`addiu || op_WB==`andi || op_WB==`ori || op_WB==`xori || op_WB==`lui || op_WB==`slti || op_WB==`sltiu)
`define In_WB_is_load (op_WB==`lw || op_WB==`lh || op_WB==`lhu || op_WB==`lb || op_WB==`lbu)
`define In_WB_is_mfc0 (op_WB==`cop0 && rs_WB==`mfc0)
`define In_WB_is_jal (op_WB==`jal)
`define In_WB_is_jalr (op_WB==`R && func_WB==`jalr)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:11:49 11/24/2018 
// Design Name: 
// Module Name:    Forwarding 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Forwarding(
    input [31:0] Instr_ID,
    input [31:0] Instr_EX,
    input [31:0] Instr_MEM,
    input [31:0] Instr_WB,
    output reg [3:0] MFRSDsel,
    output reg [3:0] MFRTDsel,
    output reg [3:0] MFRSEsel,
    output reg [3:0] MFRTEsel,
    output reg [2:0] MFRTMsel
    );
	initial begin
		MFRSDsel<=0;
		MFRTDsel<=0;
		MFRSEsel<=0;
		MFRTEsel<=0;
		MFRTMsel<=0;
	end
	
	wire [4:0]rs_ID=Instr_ID[25:21];
	wire [4:0]rt_ID=Instr_ID[20:16];
	wire [4:0]rs_EX=Instr_EX[25:21];
	wire [4:0]rt_EX=Instr_EX[20:16];
	wire [4:0]rd_EX=Instr_EX[15:11];
	wire [4:0]rs_MEM=Instr_MEM[25:21];
	wire [4:0]rt_MEM=Instr_MEM[20:16];
	wire [4:0]rd_MEM=Instr_MEM[15:11];
	wire [4:0]rs_WB=Instr_WB[25:21];
	wire [4:0]rt_WB=Instr_WB[20:16];
	wire [4:0]rd_WB=Instr_WB[15:11];
	
	wire [5:0]op_ID=Instr_ID[31:26];
	wire [5:0]func_ID=Instr_ID[5:0];
	wire [5:0]op_EX=Instr_EX[31:26];
	wire [5:0]func_EX=Instr_EX[31:26];
	wire [5:0]op_MEM=Instr_MEM[31:26];
	wire [5:0]func_MEM=Instr_MEM[5:0];
	wire [5:0]op_WB=Instr_WB[31:26];
	wire [5:0]func_WB=Instr_WB[5:0];
	
	always @(*)begin
			if ((`In_EX_is_jal && rs_ID==5'b11111)
				||(`In_EX_is_jalr && rs_ID==rd_EX && rs_ID!=0)
				)
				MFRSDsel<=4'b0001;
			else if((`In_MEM_is_r && rs_ID==rd_MEM && rs_ID!=0)
						||(`In_MEM_is_i && rs_ID==rt_MEM && rs_ID!=0)
						)
				MFRSDsel<=4'b0010;
			else if((`In_MEM_is_jal && rs_ID==5'b11111)
						||(`In_MEM_is_jalr && rs_ID==rd_MEM && rs_ID!=0)
						)
				MFRSDsel<=4'b0011;
			else if (`In_MEM_is_mfhi && rs_ID==rd_MEM && rs_ID!=0)
				MFRSDsel<=4'b0110;
			else if (`In_MEM_is_mflo && rs_ID==rd_MEM && rs_ID!=0)
				MFRSDsel<=4'b0111;
			else if ((`In_WB_is_r && rs_ID==rd_WB && rs_ID!=0)
						||(`In_WB_is_i && rs_ID==rt_WB && rs_ID!=0)
						||(`In_WB_is_load && rs_ID==rt_WB && rs_ID!=0)
						||(`In_WB_is_mfc0 && rs_ID==rt_WB && rs_ID!=0)
						)
				MFRSDsel<=4'b0100;
			else if((`In_WB_is_jal && rs_ID==5'b11111)
						||(`In_WB_is_jalr && rs_ID==rd_WB && rs_ID!=0)
						)
				MFRSDsel<=4'b0101;
			else if (`In_WB_is_mfhi && rs_ID==rd_WB && rs_ID!=0)
				MFRSDsel<=4'b1000;
			else if (`In_WB_is_mflo && rs_ID==rd_WB && rs_ID!=0)
				MFRSDsel<=4'b1001;
			else
				MFRSDsel<=0;
	end
	
	always @(*)begin
			if ((`In_EX_is_jal && rt_ID==5'b11111)
				||(`In_EX_is_jalr && rt_ID==rd_EX && rt_ID!=0)
				)
				MFRTDsel<=4'b0001;
			else if((`In_MEM_is_r && rt_ID==rd_MEM && rt_ID!=0)
						||(`In_MEM_is_i && rt_ID==rt_MEM && rt_ID!=0)
						)
				MFRTDsel<=4'b0010;
			else if((`In_MEM_is_jal && rt_ID==5'b11111)
						||(`In_MEM_is_jalr && rt_ID==rd_MEM && rt_ID!=0)
						)
				MFRTDsel<=4'b0011;
			else if (`In_MEM_is_mfhi && rt_ID==rd_MEM && rt_ID!=0)
				MFRTDsel<=4'b0110;
			else if (`In_MEM_is_mflo && rt_ID==rd_MEM && rt_ID!=0)
				MFRTDsel<=4'b0111;
			else if ((`In_WB_is_r && rt_ID==rd_WB && rt_ID!=0)
						||(`In_WB_is_i && rt_ID==rt_WB && rt_ID!=0)
						||(`In_WB_is_load && rt_ID==rt_WB && rt_ID!=0)
						||(`In_WB_is_mfc0 && rt_ID==rt_WB && rt_ID!=0)
						)
				MFRTDsel<=4'b0100;
			else if((`In_WB_is_jal && rt_ID==5'b11111)
						||(`In_WB_is_jalr && rt_ID==rd_WB && rt_ID!=0)
						)
				MFRTDsel<=4'b0101;
			else if (`In_WB_is_mfhi && rt_ID==rd_WB && rt_ID!=0)
				MFRTDsel<=4'b1000;
			else if (`In_WB_is_mflo && rt_ID==rd_WB && rt_ID!=0)
				MFRTDsel<=4'b1001;
			else
				MFRTDsel<=0;
	end
	
	always @(*)begin
			if((`In_MEM_is_r && rs_EX==rd_MEM && rs_EX!=0)
				||(`In_MEM_is_i && rs_EX==rt_MEM && rs_EX!=0)
				)
				MFRSEsel<=4'b0001;
			else if ((`In_MEM_is_jal && rs_EX==5'b11111)
						||(`In_MEM_is_jalr && rs_EX==rd_MEM && rs_EX!=0)
						)
				MFRSEsel<=4'b0010;
			else if (`In_MEM_is_mfhi && rs_EX==rd_MEM && rs_EX!=0)
				MFRSEsel<=4'b0101;
			else if (`In_MEM_is_mflo && rs_EX==rd_MEM && rs_EX!=0)
				MFRSEsel<=4'b0110;
			else if ((`In_WB_is_r && rs_EX==rd_WB && rs_EX!=0)
						||(`In_WB_is_i && rs_EX==rt_WB && rs_EX!=0)
						||(`In_WB_is_load && rs_EX==rt_WB && rs_EX!=0)
						||(`In_WB_is_mfc0 && rs_EX==rt_WB && rs_EX!=0)
						)
				MFRSEsel<=4'b0011;
			else if ((`In_WB_is_jal && rs_EX==5'b11111)
						||(`In_WB_is_jalr && rs_EX==rd_WB && rs_EX!=0)
						)
				MFRSEsel<=4'b0100;
			else if (`In_WB_is_mfhi && rs_EX==rd_WB && rs_EX!=0)
				MFRSEsel<=4'b0111;
			else if (`In_WB_is_mflo && rs_EX==rd_WB && rs_EX!=0)
				MFRSEsel<=4'b1000;
			else
				MFRSEsel<=4'b0000;
	end
	
	always @(*)begin
			if((`In_MEM_is_r && rt_EX==rd_MEM && rt_EX!=0)
				||(`In_MEM_is_i && rt_EX==rt_MEM && rt_EX!=0)
				)
				MFRTEsel<=4'b0001;
			else if ((`In_MEM_is_jal && rt_EX==5'b11111)
						||(`In_MEM_is_jalr && rt_EX==rd_MEM && rt_EX!=0)
						)
				MFRTEsel<=4'b0010;
			else if (`In_MEM_is_mfhi && rt_EX==rd_MEM && rt_EX!=0)
				MFRTEsel<=4'b0101;
			else if (`In_MEM_is_mflo && rt_EX==rd_MEM && rt_EX!=0)
				MFRTEsel<=4'b0110;
			else if ((`In_WB_is_r && rt_EX==rd_WB && rt_EX!=0)
						||(`In_WB_is_i && rt_EX==rt_WB && rt_EX!=0)
						||(`In_WB_is_load && rt_EX==rt_WB && rt_EX!=0)
						||(`In_WB_is_mfc0 && rt_EX==rt_WB && rt_EX!=0)
						)
				MFRTEsel<=4'b0011;
			else if ((`In_WB_is_jal && rt_EX==5'b11111)
						||(`In_WB_is_jalr && rt_EX==rd_WB && rt_EX!=0)
						)
				MFRTEsel<=4'b0100;
			else if (`In_WB_is_mfhi && rt_EX==rd_WB && rt_EX!=0)
				MFRTEsel<=4'b0111;
			else if (`In_WB_is_mflo && rt_EX==rd_WB && rt_EX!=0)
				MFRTEsel<=4'b1000;
			else
				MFRTEsel<=4'b0000;
	end
	
	always @(*)begin
			if ((`In_WB_is_r && rt_MEM==rd_WB && rt_MEM!=0)
				||(`In_WB_is_i && rt_MEM==rt_WB && rt_MEM!=0)
				||(`In_WB_is_load && rt_MEM==rt_WB && rt_MEM!=0)
				||(`In_WB_is_mfc0 && rt_MEM==rt_WB && rt_MEM!=0)
				)
				MFRTMsel<=3'b001;
			else if ((`In_WB_is_jal && rt_MEM==5'b11111)
						||(`In_WB_is_jalr && rt_MEM==rd_WB && rt_MEM!=0)
						)
				MFRTMsel<=3'b010;
			else if (`In_WB_is_mfhi && rt_MEM==rd_WB && rt_MEM!=0)
				MFRTMsel<=3'b011;
			else if (`In_WB_is_mflo && rt_MEM==rd_WB && rt_MEM!=0)
				MFRTMsel<=3'b100;
			else
				MFRTMsel<=3'b000;
	end
endmodule
