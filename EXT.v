`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:17 11/23/2018 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] In,
    input [1:0] EXTsel,
    output reg [31:0] EXTOut
    );
	always @(*)begin
		case(EXTsel)
			2'b00: EXTOut<={16'h0000,In};
			2'b01: EXTOut<={{16{In[15]}},In};
			2'b10: EXTOut<={In,16'h0000};
		endcase
	end

endmodule
