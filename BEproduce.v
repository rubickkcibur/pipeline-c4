`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:25:53 12/07/2018 
// Design Name: 
// Module Name:    BEproduce 
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
module BEproduce(
    input [31:0] address,
    input [1:0] BEsel,
    output reg [3:0] BE
    );
	wire [1:0]lo=address[1:0];
	always @(*)begin
		case(BEsel)
			2'b00: BE<=4'b1111;
			2'b01: begin
				if (lo==0)
					BE<=4'b0011;
				else if (lo==2)
					BE<=4'b1100;
				else
					BE<=0;
				end
			2'b10: begin
				if (lo==0)
					BE<=4'b0001;
				else if (lo==1)
					BE<=4'b0010;
				else if (lo==2)
					BE<=4'b0100;
				else
					BE<=4'b1000;
				end
			default:
				BE<=4'b0000;
		endcase
	end

endmodule
