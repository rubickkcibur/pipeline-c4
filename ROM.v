`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:14 11/23/2018 
// Design Name: 
// Module Name:    ROM 
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
module ROM(
    input [31:0] Pc,
    output reg [31:0] Instr
    );
	wire [12:0] instrsel;
	reg [31:0] rom[32'h00000c00:32'h00001bff];
	integer i=0;
	assign instrsel=Pc[14:2];//÷∏¡Ó—°‘Ò–≈∫≈
	
	initial begin
		for (i=32'h00000c00;i<=32'h00001bff;i=i+1)
			rom[i]=32'h00000000;
		$readmemh("code.txt",rom);
		$readmemh("code_handler.txt",rom,32'h00001060);
	end
	
	always @(*) begin
		Instr<=rom[instrsel];
	end
endmodule
