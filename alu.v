`timescale 1ns / 1ps

module alu(
//input clk,rst,
input [31:0]a,b,
input [3:0] ALUctrl,
output reg [31:0]result,
output Zero
    );
    parameter AND=4'b0000;
    parameter OR=4'b0001;
    parameter ADD=4'b0010;
    parameter SUB=4'b0110;
    parameter SLT=4'b0111;
    parameter NOR=4'b1100;
    
 always @ (*) begin
	case(ALUctrl)
		AND: result <= a&b;
		OR: result <= a|b;
		ADD: result <= a+b;
		SUB: result <= a-b ;
		SLT: result <= (a<b);
		NOR:result <= ~(a|b);
		default: result <= 0;
	endcase
end
 
 assign Zero = (result==0);

        
endmodule

module alu_control(
 input [1:0] aluop,
 input [5:0] functioncode,
 output reg [3:0] ALUctrl
 );
 always @(*) begin
    case(aluop)
		2'b00:ALUctrl <= 4'b0010; 
		2'b01: ALUctrl <= 4'b0110; 
		2'b10:  begin
			case(functioncode)
				6'b100000: ALUctrl <= 4'b0010; 
				6'b100010: ALUctrl <= 4'b0110; 
				6'b100100: ALUctrl <= 4'b0000; 
				6'b100101: ALUctrl <= 4'b0001;
				6'b101010: ALUctrl <= 4'b0111; 
				default: ALUctrl <= 4'b1111;
			endcase
		end
		2'b11: ALUctrl <= 4'b0001; 
		default: ALUctrl <= 4'b1111;
  endcase
 end
endmodule


