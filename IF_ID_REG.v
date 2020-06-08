`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:44 11/23/2018 
// Design Name: 
// Module Name:    IF_ID_REG 
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
module IF_ID_REG(
    input [31:0] Pc,
	 input [31:0]EPC,
    input [31:0] Instr,
	 input [4:0]exccode,
	 input delay,
	 input Reset,
	 input Estall,
	 input Clk,
	 input Enable,
    output reg [31:0] Pc_ID,
    output reg [31:0] Instr_ID,
	 output reg [4:0]exccode_ID,
	 output reg delay_ID
    );
	 
	 initial begin
		Pc_ID<=32'h00003000;
		Instr_ID<=0;
		exccode_ID<=0;
		delay_ID<=0;
		end
		
	always @(posedge Clk)begin
		if (Reset) begin
			Pc_ID<=Pc;
			Instr_ID<=0;
			exccode_ID<=0;
			delay_ID<=0;
		end
		else if (Estall)begin
			Pc_ID<=EPC;
			Instr_ID<=0;
			exccode_ID<=0;
			delay_ID<=0;
		end
		else if (Enable)begin
			Pc_ID<=Pc;
			Instr_ID<=Instr;
			exccode_ID<=exccode;
			delay_ID<=delay;
		end
	end

endmodule
