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

`define cp0 6'b010000
`define eret 6'b011000
`define mfc0 5'b00000
`define mtc0 5'b00100 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:32 12/15/2018 
// Design Name: 
// Module Name:    ID_Exception 
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
module ID_Exception(
    input [31:0] Instr,
    output nop,
    output [4:0] exccode
    );
	 wire [5:0]op=Instr[31:26];
	 wire [5:0]func=Instr[5:0];
	 wire [4:0]BZ=Instr[20:16];
	 wire [4:0]c0=Instr[25:21];
	wire flag=(op==`addi)||
					(op==`addiu)||
					(op==`andi)||
					(op==`ori)||
					(op==`xori)||
					(op==`lui)||
					(op==`slti)||
					(op==`sltiu)||
					(op==`beq)||
					(op==`bne)||
					(op==`blez)||
					(op==`bgtz)||
					(op==`BZ && (BZ==`bltz || BZ==`bgez))||
					(op==`j)||
					(op==`jal)||
					(op==`sw)||
					(op==`sh)||
					(op==`sb)||
					(op==`lw)||
					(op==`lh)||
					(op==`lhu)||
					(op==`lb)||
					(op==`lbu)||
					(op==`R && ((func==`add)||
									(func==`addu)||
									(func==`sub)||
									(func==`subu)||
									(func==`sllv)||
									(func==`srav)||
									(func==`srlv)||
									(func==`AND)||
									(func==`OR)||
									(func==`XOR)||
									(func==`NOR)||
									(func==`slt)||
									(func==`sltu)||
									(func==`sll)||
									(func==`srl)||
									(func==`sra)||
									(func==`jr)||
									(func==`jalr)||
									(func==`mult)||
									(func==`div)||
									(func==`multu)||
									(func==`divu)||
									(func==`mfhi)||
									(func==`mflo)||
									(func==`mthi)||
									(func==`mtlo)
								))||
					(op==`cp0 && func==`eret)||
					(op==`cp0 && c0==`mfc0)||
					(op==`cp0 && c0==`mtc0);
	assign nop=~flag;
	assign exccode=flag?0:10;

endmodule
