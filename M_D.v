`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:04:48 12/08/2018 
// Design Name: 
// Module Name:    M_D 
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
module M_D(
    input start,
    input [31:0] D1,
    input [31:0] D2,
    input [2:0] sel,
	 input clk,
	 input reset,
	 input IntReq,
	 input remthi,
	 input remtlo,
    output reg Busy,
    output reg [31:0] HI,
    output reg [31:0] LO
    );
	integer state_m;
	integer state_mu;
	integer state_d;
	integer state_du;
	reg [63:0] unsignedout;
	reg signed [63:0] signedout;
	reg [31:0]preHI;
	reg [31:0]preLO;
	
	initial begin
		Busy<=0;
		HI<=0;
		LO<=0;
		unsignedout<=0;
		preHI<=0;
		preLO<=0;
		signedout<=0;
		state_m<=0;
		state_mu<=0;
		state_d<=0;
		state_du<=0;
	end

	always @(posedge clk)begin
		if (reset)begin
			Busy<=0;
			HI<=0;
			LO<=0;
			unsignedout<=0;
			signedout<=0;
			state_m<=0;
			state_mu<=0;
			state_d<=0;
			state_du<=0;
		end
		else begin
			//mult
			case(state_m)
				0: begin
					if (start && (sel==0) && ~IntReq)begin
						state_m<=1;
						Busy<=1;
						signedout<=$signed(D1)*$signed(D2);
					end
					else 
						state_m<=0;
					end
				1: begin
					if (IntReq)begin
						state_m<=0;
						Busy<=0;
					end
					else
						state_m<=state_m+1;
					end
				5: begin
						state_m<=0;
						Busy<=0;
						{HI,LO}<=signedout;
					end
				default:
					state_m<=state_m+1;
			endcase
		
			//multu
			case(state_mu)
				0: begin
					if (start && (sel==1) && ~IntReq)begin
						state_mu<=1;
						Busy<=1;
						unsignedout<=D1*D2;
					end
					else
						state_mu<=0;
					end
				1: begin
					if (IntReq)begin
						state_mu<=0;
						Busy<=0;
					end
					else
						state_mu<=state_mu+1;
					end
				5: begin
						state_mu<=0;
						Busy<=0;
						{HI,LO}<=unsignedout;
					end
				default:
					state_mu<=state_mu+1;
			endcase
		
			//div
			case(state_d)
				0: begin
					if (start && (sel==2) && ~IntReq)begin
						state_d<=1;
						Busy<=1;
						signedout[31:0]<=$signed(D1)/$signed(D2);
						signedout[63:32]<=$signed(D1)%$signed(D2);
					end
					else
						state_d<=0;
					end
				1: begin
					if (IntReq)begin
						state_d<=0;
						Busy<=0;
					end
					else
						state_d<=state_d+1;
					end
				10: begin
						state_d<=0;
						Busy<=0;
						{HI,LO}<=signedout;
					end
				default:
					state_d<=state_d+1;
			endcase
		
			//divu
			case(state_du)
				0: begin
					if (start && (sel==3) && ~IntReq)begin
						state_du<=1;
						Busy<=1;
						unsignedout[31:0]<=D1/D2;
						unsignedout[63:32]<=D1%D2;
					end
					else
						state_du<=0;
					end
				1: begin
					if (IntReq)begin
						state_du<=0;
						Busy<=0;
					end
					else
						state_du<=state_du+1;
					end
				10: begin
						state_du<=0;
						Busy<=0;
						{HI,LO}<=unsignedout;
					end
				default:
					state_du<=state_du+1;
			endcase
		
			//mtlhi
			if ((sel==4) && ~IntReq)begin
				preHI<=HI;
				HI<=D1;
			end
			//mtlo
			if ((sel==5) && ~IntReq)begin
				preLO<=LO;
				LO<=D1;
			end
			//remthi
			if (remthi)
				HI<=preHI;
			//rentlo
			if (remtlo)
				LO<=preLO;
		end
	end
	
endmodule
