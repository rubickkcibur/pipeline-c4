`timescale 1ns / 1ps
`define po (((A[31]==1 && B[31]==1 && AplusB[31]==0)||(A[31]==0 && B[31]==0 && AplusB[31]==1))&&(Op==4'b0010))
`define mo (((A[31]==1 && B[31]==0 && AminusB[31]==0)||(A[31]==0 && B[31]==1 && AminusB[31]==1))&&(Op==4'b0011))
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:25 11/23/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] Op,
    output reg [31:0] C,
	 output Overflow
    );
	 wire [4:0]s=A[4:0];
	 wire [31:0]AplusB=A+B;
	 wire [31:0]AminusB=A-B;
	always @(*)begin
		case(Op)
			4'b0000: C<=A&B;
			4'b0001: C<=A|B;
			4'b0010: C<=A+B;
			4'b0011: C<=A-B;
			4'b0100: C<=A^B;
			4'b0101: C<=~(A|B);
			4'b0110:	C<=B<<s;
			4'b0111: C<=B>>s;
			4'b1000: C<=$signed(B)>>>s;
			4'b1001: C<=$signed(A)<$signed(B);
			4'b1010: C<=A<B;
		endcase
	end
	assign Overflow=`po|`mo;
endmodule
