`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:03 12/07/2018 
// Design Name: 
// Module Name:    Load_ext 
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
module Load_ext(
    input [31:0] address,
    input [31:0] Rdata,
    input [2:0] loadsel,
    output reg [31:0] out
    );
	wire [1:0]lo=address[1:0];
	wire [15:0]half;
	wire [7:0]byt;
	assign half=(lo==0)?Rdata[15:0]:
					(lo==2)?Rdata[31:16]:0;
					
	assign byt=(lo==0)?Rdata[7:0]:
					(lo==1)?Rdata[15:8]:
					(lo==2)?Rdata[23:16]:Rdata[31:24];
					
	always @(*)begin
		case(loadsel)
			3'b000: out<=Rdata;
			3'b001: out<={{16{half[15]}},half};
			3'b010: out<={16'h0000,half};
			3'b011: out<={{24{byt[7]}},byt};
			3'b100: out<={24'h000000,byt};
			default: out<=0;
		endcase
	end
					

endmodule
