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
// Create Date:    15:52:26 11/24/2018 
// Design Name: 
// Module Name:    ID_Controller 
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
module ID_Controller(
    input [31:0] Instr_ID,
    output reg [1:0] EXTsel,
    output reg [2:0] MUX_PCsel,
	 output reg [2:0] bcp
    );
	 wire [5:0]op;
	 wire [5:0]func;
	 assign op=Instr_ID[31:26];
	 assign func=Instr_ID[5:0];
	 
	initial begin
		EXTsel<=2'b00;
		MUX_PCsel<=2'b00;
		bcp<=0;
	end
	
	always @(*)begin
		case(op)
			`addi: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`addiu: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`andi: begin
				EXTsel<=2'b00;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`ori: begin
				EXTsel<=2'b00;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`xori: begin
				EXTsel<=2'b00;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`lui: begin
				EXTsel<=2'b10;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`slti: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`sltiu: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`beq: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b001;
				bcp<=3'b000;
				end
			`bne: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b001;
				bcp<=3'b001;
				end
			`blez: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b001;
				bcp<=3'b010;
				end
			`bgtz: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b001;
				bcp<=3'b011;
				end
			`BZ: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b001;
				if (Instr_ID[20:16]==`bltz)
					bcp<=3'b100;
				else if (Instr_ID[20:16]==`bgez)
					bcp<=3'b101;
				else
					bcp<=0;
				end
			`j: begin
				EXTsel<=2'b00;
				MUX_PCsel<=3'b010;
				bcp<=3'b000;
				end
			`jal: begin
				EXTsel<=2'b00;
				MUX_PCsel<=3'b010;
				bcp<=3'b000;
				end
			`sw: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`sh: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`sb: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`lw: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`lh: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`lhu: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`lb: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`lbu: begin
				EXTsel<=2'b01;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`cop0: begin
				EXTsel<=2'b00;
				if (func==`eret)
					MUX_PCsel<=3'b100;
				else
					MUX_PCsel<=3'b000;
				bcp<=3'b000;
				end
			`R: begin
				case(func)
					`jalr: begin
						EXTsel<=2'b00;
						MUX_PCsel<=3'b011;
						bcp<=3'b000;
						end
					`jr: begin
						EXTsel<=2'b00;
						MUX_PCsel<=3'b011;
						bcp<=3'b000;
						end
					default: begin
						EXTsel<=2'b00;
						MUX_PCsel<=3'b000;
						bcp<=3'b000;
						end
				endcase
				end
			default: begin
				EXTsel<=2'b00;
				MUX_PCsel<=3'b000;
				bcp<=3'b000;
			end
		endcase
	end
endmodule
