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
// Create Date:    15:32:22 11/24/2018 
// Design Name: 
// Module Name:    WB_Controller 
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
module WB_Controller(
    input [31:0] Instr_WB,
	 output reg [2:0] Load_extsel,
    output reg [1:0] MUX_WAsel,
    output reg [2:0] MUX_WDsel,
	 output reg WE
    );
	 wire [5:0]op;
	 wire [5:0]func;
	 wire [4:0]rs;
	 assign op=Instr_WB[31:26];
	 assign func=Instr_WB[5:0];
	 assign rs=Instr_WB[25:21];
	 
	 
	initial begin
		Load_extsel<=3'b000;
		MUX_WAsel<=0;
		MUX_WDsel<=0;
		WE<=0;
	end
	
	always @(*)begin
		case(op)
			`addi: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`addiu: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`andi: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`ori: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`xori: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`lui: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`slti: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`sltiu: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b000;
				WE<=1;
				end
			`beq: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`bne: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`blez: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`bgtz: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`BZ: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`j: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`jal: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b10;
				MUX_WDsel<=3'b001;
				WE<=1;
				end
			`sw: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`sh: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`sb: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
				end
			`lw: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b010;
				WE<=1;
				end
			`lh: begin
				Load_extsel<=3'b001;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b010;
				WE<=1;
				end
			`lhu: begin
				Load_extsel<=3'b010;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b010;
				WE<=1;
				end
			`lb: begin
				Load_extsel<=3'b011;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b010;
				WE<=1;
				end
			`lbu: begin
				Load_extsel<=3'b100;
				MUX_WAsel<=2'b01;
				MUX_WDsel<=3'b010;
				WE<=1;
				end
			`cop0: begin
				Load_extsel<=3'b000;
				if (rs==`mfc0) begin
					MUX_WAsel<=2'b01;
					MUX_WDsel<=3'b101;
					WE<=1;
					end
				else begin
					MUX_WAsel<=2'b00;
					MUX_WDsel<=3'b000;
					WE<=0;
					end
				end
			`R: begin
				case(func)
					`add: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`addu: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`sub: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`subu: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`sllv: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`srav: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`srlv: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`AND: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`OR: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`XOR: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`NOR: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`slt: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`sltu: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`sll: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`srl: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`sra: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=1;
						end
					`jalr: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b001;
						WE<=1;
						end
					`jr: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`mult: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`multu: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`div: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`divu: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`mthi: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`mtlo: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
					`mfhi: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b011;
						WE<=1;
						end
					`mflo: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b100;
						WE<=1;
						end
					default: begin
						Load_extsel<=3'b000;
						MUX_WAsel<=2'b00;
						MUX_WDsel<=3'b000;
						WE<=0;
						end
				endcase
				end
			default: begin
				Load_extsel<=3'b000;
				MUX_WAsel<=2'b00;
				MUX_WDsel<=3'b000;
				WE<=0;
			end
		endcase
	end
endmodule

