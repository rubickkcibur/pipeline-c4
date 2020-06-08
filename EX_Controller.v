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
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:00 11/24/2018 
// Design Name: 
// Module Name:    EX_Controller 
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
module EX_Controller(
    input [31:0] Instr_EX,
	 output reg [2:0]M_Dsel,
	 output reg MUX_ALU_Asel,
    output reg MUX_ALU_Bsel,
    output reg [3:0] ALUop
    );
	 wire [5:0]op;
	 wire [5:0]func;
	 assign op=Instr_EX[31:26];
	 assign func=Instr_EX[5:0];
	 
	initial begin
		M_Dsel<=0;
		MUX_ALU_Asel<=0;
		MUX_ALU_Bsel<=0;
		ALUop<=0;
	end
	
	always @(*)begin
		case(op)
			`addi: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`addiu: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`andi: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0000;
				end
			`ori: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0001;
				end
			`xori: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0100;
				end
			`lui: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0001;
				end
			`slti: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b1001;
				end
			`sltiu: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b1010;
				end
			`beq: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`bne: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`blez: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`bgtz: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`BZ: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`j: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`jal: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`sw: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`sh: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`sb: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`lw: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`lh: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`lhu: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`lb: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`lbu: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=1;
				ALUop<=4'b0010;
				end
			`cop0: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
				end
			`R: begin
				case(func)
					`add: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0010;
						end
					`addu: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0010;
						end
					`sub: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0011;
						end
					`subu: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0011;
						end
					`sllv: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0110;
						end
					`srav: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b1000;
						end
					`srlv: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0111;
						end
					`AND: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`OR: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0001;
						end
					`XOR: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0100;
						end
					`NOR: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0101;
						end
					`slt: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b1001;
						end
					`sltu: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b1010;
						end
					`sll: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=1;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0110;
						end
					`srl: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=1;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0111;
						end
					`sra: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=1;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b1000;
						end
					`jalr: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`jr: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`mult: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`multu: begin
						M_Dsel<=3'b001;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`div: begin
						M_Dsel<=3'b010;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`divu: begin
						M_Dsel<=3'b011;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`mthi: begin
						M_Dsel<=3'b100;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					`mtlo: begin
						M_Dsel<=3'b101;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
					default: begin
						M_Dsel<=3'b000;
						MUX_ALU_Asel<=0;
						MUX_ALU_Bsel<=0;
						ALUop<=4'b0000;
						end
				endcase
				end
			default: begin
				M_Dsel<=3'b000;
				MUX_ALU_Asel<=0;
				MUX_ALU_Bsel<=0;
				ALUop<=4'b0000;
			end
		endcase
	end
endmodule
