`timescale 1ns / 1ps
`define WAIT 0
`define LOAD 1
`define COUNT 2
`define INT 3
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:29 12/14/2018 
// Design Name: 
// Module Name:    Timer 
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
module Timer(
    input CLK_I,
    input RST_I,
    input [31:0] address,
    input WE_I,
    input [31:0] DAT_I,
    output [31:0] DAT_O,
    output IRQ
    );
	 
	reg [31:0]CTRL;
	reg [31:0]PRESET;
	reg [31:0]COUNT;
	reg _IRQ;
	integer state=0;
	wire [1:0]ADD_I=address[3:2];
	wire enable=CTRL[0];
	wire mode=CTRL[2:1];
	wire IM=CTRL[3];
	
	initial begin
		CTRL<=0;
		PRESET<=0;
		COUNT<=0;
		state<=0;
		_IRQ<=0;
	end
	
	always @(posedge CLK_I)begin
		if (RST_I)begin
			CTRL<=0;
			PRESET<=0;
			COUNT<=0;
			state<=0;
			_IRQ<=0;
		end
		else begin
			if (WE_I)begin
				if (ADD_I==0)
					CTRL<=DAT_I;
				if (ADD_I==1)
					PRESET<=DAT_I;
			end
			else
				case(state)
					`WAIT: begin
						if(enable)begin
							_IRQ<=0;
							state<=`LOAD;
						end
						else
							state<=`WAIT;
					end
					
					`LOAD: begin
						COUNT<=PRESET;
						state<=`COUNT;
					end
					
					`COUNT: begin
						if (enable)begin
							if (COUNT<=1)begin
								COUNT<=0;
								_IRQ<=1;
								state<=`INT;
							end
							else begin
								COUNT<=COUNT-1;
								state<=`COUNT;
							end
						end
						else begin
							COUNT<=0;
							state<=`WAIT;
						end
					end
					
					`INT: begin
						if (mode==0)begin
							COUNT<=0;
							CTRL[0]<=0;
							state<=`WAIT;
						end
						else begin
							COUNT<=0;
							_IRQ<=0;
							state<=`WAIT;
						end
					end
				endcase
		end
	end
	assign DAT_O=(ADD_I==0)?CTRL:
					(ADD_I==1)?PRESET:
					(ADD_I==2)?COUNT:0;
	assign IRQ=_IRQ&IM;
endmodule
