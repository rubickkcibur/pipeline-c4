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
`define BZ 6'b000001//是bltz或者bgez
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

`define EX_is_r (op_EX==`R && func_EX!=`jr)
`define EX_is_i (op_EX==`ori || op_EX==`lui)
`define EX_is_load (op_EX==`lw)
`define MEM_is_load (op_MEM==`lw)

`define Tuse_rs_0 ((op_ID==`beq || op_ID==`bne || op_ID==`blez || op_ID==`bgtz || op_ID==`BZ)\
						||(op_ID==`R && func_ID==`jr)\
						||(op_ID==`R && func_ID==`jalr)\
						)
						
`define Tuse_rt_0 (op_ID==`beq || op_ID==`bne)

`define Tuse_EPC_0 (op_ID==`cop0 && func_ID==`eret)

`define Tuse_rs_1 ((op_ID==`R && func_ID!=`jr && func_ID!=`jalr)\
						||(op_ID==`addi || op_ID==`addiu || op_ID==`andi || op_ID==`ori || op_ID==`xori || op_ID==`lui || op_ID==`slti || op_ID==`sltiu)\
						||(op_ID==`sw || op_ID==`sh || op_ID==`sb)\
						||(op_ID==`lw || op_ID==`lh || op_ID==`lhu || op_ID==`lb || op_ID==`lbu)\
						)
						
`define Tuse_rt_1 (op_ID==`R && func_ID!=`jr && func_ID!=`jalr)

`define Tnew_rt_1_E (op_EX==`addi || op_EX==`addiu || op_EX==`andi || op_EX==`ori || op_EX==`xori || op_EX==`lui || op_EX==`slti || op_EX==`sltiu)

`define Tnew_rd_1_E (op_EX==`R && func_EX!=`jr && func_EX!=`jalr && func_EX!=`mult && func_EX!=`multu && func_EX!=`div && func_EX!=`divu && func_EX!=`mthi && func_EX!=`mtlo)
//注意此处rd的Tnew宏定义是使用排除法做的，若添加R型指令需要再看是否需要更改

`define Tnew_rt_2_E (op_EX==`lw || op_EX==`lh || op_EX==`lhu || op_EX==`lb || op_EX==`lbu || (op_EX==`cop0 && rs_EX==`mfc0))

`define Tnew_rt_1_M (op_MEM==`lw || op_MEM==`lh || op_MEM==`lhu || op_MEM==`lb || op_MEM==`lbu || (op_MEM==`cop0 && rs_MEM==`mfc0))

`define Tnew_EPC_1_E (op_EX==`cop0 && rs_EX==`mtc0 && rd_EX==5'b01110)

`define M_D_ID (op_ID==`R &&(func_ID==`mult || func_ID==`multu || func_ID==`div || func_ID==`divu || func_ID==`mthi || func_ID==`mtlo || func_ID==`mfhi || func_ID==`mflo))

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:46 11/24/2018 
// Design Name: 
// Module Name:    Installer 
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
module Installer(
    input [31:0] Instr_ID,
    input [31:0] Instr_EX,
    input [31:0] Instr_MEM,
	 input Busy_start,
    output Enable_PC,
    output Enable_IF_ID,
    output Reset_ID_EX
    );
	 
	wire i;
	
	wire [4:0]rs_ID;
	wire [4:0]rt_ID;
	wire [4:0]rs_EX;
	wire [4:0]rd_EX;
	wire [4:0]rt_EX;
	wire [4:0]rs_MEM;
	wire [4:0]rt_MEM;
	wire [5:0]op_ID;
	wire [5:0]func_ID;
	wire [5:0]op_EX;
	wire [5:0]func_EX;
	wire [5:0]op_MEM;
	wire [5:0]func_MEM;
	
	assign rs_ID=Instr_ID[25:21];
	assign rt_ID=Instr_ID[20:16];
	assign rs_EX=Instr_EX[25:21];
	assign rd_EX=Instr_EX[15:11];
	assign rt_EX=Instr_EX[20:16];
	assign rs_MEM=Instr_MEM[25:21];
	assign rt_MEM=Instr_MEM[20:16];
	
	assign op_ID=Instr_ID[31:26];
	assign func_ID=Instr_ID[5:0];
	assign op_EX=Instr_EX[31:26];
	assign func_EX=Instr_EX[5:0];
	assign op_MEM=Instr_MEM[31:26];
	assign func_MEM=Instr_MEM[5:0];
	
	assign i=((`Tuse_rs_0 && `Tnew_rd_1_E && rs_ID==rd_EX && rs_ID!=0)
		||(`Tuse_rs_0 && `Tnew_rt_1_E && rs_ID==rt_EX && rs_ID!=0)
		||(`Tuse_rs_0 && `Tnew_rt_2_E && rs_ID==rt_EX && rs_ID!=0)
		||(`Tuse_rs_0 && `Tnew_rt_1_M && rs_ID==rt_MEM && rs_ID!=0)
		
		||(`Tuse_rt_0 && `Tnew_rd_1_E && rt_ID==rd_EX && rt_ID!=0)
		||(`Tuse_rt_0 && `Tnew_rt_1_E && rt_ID==rt_EX && rt_ID!=0)
		||(`Tuse_rt_0 && `Tnew_rt_2_E && rt_ID==rt_EX && rt_ID!=0)
		||(`Tuse_rt_0 && `Tnew_rt_1_M && rt_ID==rt_MEM && rt_ID!=0)
		
		||(`Tuse_rs_1 && `Tnew_rt_2_E && rs_ID==rt_EX && rs_ID!=0)
		
		||(`Tuse_rt_1 && `Tnew_rt_2_E && rt_ID==rt_EX && rt_ID!=0)
		
		||(`M_D_ID && Busy_start)
		
		||(`Tuse_EPC_0 && `Tnew_EPC_1_E)
		);
	
	assign Enable_PC=i?0:1;
	assign Enable_IF_ID=i?0:1;
	assign Reset_ID_EX=i?1:0;
	
endmodule
