`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:11 12/15/2018 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input [4:0] RA,
    input [4:0] WA,
    input [31:0] WD,
    input [31:0] PC,
    input [4:0] ExcCode,
    input [5:0] HWInt,
	 input delay,
    input WE,
    input EXLClr,
    input clk,
    input reset,
    output IntReq,
    output reg [31:0] EPC,
    output [31:0] RD
    );
	reg [31:0]SR;
	reg [31:0]Cause;
	reg [31:0]PRId;
	wire exception=|ExcCode;
	wire [5:0]IM=SR[15:10];
	wire EXL=SR[1];
	wire IE=SR[0];
	wire [5:0]IP=Cause[15:10];
	wire [4:0]exccode=Cause[6:2];
	wire BD=Cause[31];
	wire interrupt=(|(HWInt[5:0]&IM[5:0]))&IE&(~EXL);
	
	initial begin
		SR<=0;
		Cause<=0;
		PRId<=32'h17373488;
		EPC<=0;
	end
	always @(posedge clk)begin
		if (EXLClr)
			SR[1]<=0;
		if (reset)begin
			SR<=0;
			Cause<=0;
			EPC<=0;
			PRId<=32'h17373488;
		end
		else begin
			if (interrupt)begin
				EPC<=delay?(PC-4):{PC[31:2],2'b00};
				Cause[6:2]<=0;
				Cause[31]<=delay;
				Cause[15:10]<=HWInt;
				SR[1]<=1;
			end
			else if (exception&~EXL)begin
				EPC<=delay?(PC-4):{PC[31:2],2'b00};
				Cause[6:2]<=ExcCode;
				Cause[31]<=delay;
				Cause[15:10]<=HWInt;
				SR[1]<=1;
			end
			else begin
				if (WE)begin
					case (WA)
						12: SR<=WD;
						14: EPC<={WD[31:2],2'b00};
						default: ;
					endcase
				end
			end
		end
	end
	assign RD=(RA==12)?SR:
				(RA==13)?Cause:
				(RA==14)?EPC:
				(RA==15)?PRId:
				0;
	assign IntReq=interrupt|(exception&~EXL);
endmodule
