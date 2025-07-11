`timescale 1ns / 1ps

module control_unit(
input [5:0] op,
 output reg RegDst,Branch,MemtoReg,ALUSrc,RegWrite,MemWrite,MemRead,Jump,
 output reg [1:0] ALUop
    );
   // {RegDst,jump,Branch,MemtoReg,ALUSrc,RegWrite,MemWrite,MemRead,}=;

    always@(*)begin
    	case(op)
    	//R type
			  6'd0:begin 
			RegDst <= 1;  ALUop <= 2'b10;Branch<=0;
			MemtoReg <= 0; RegWrite <= 1;Jump<=0;
			MemWrite <= 0; MemRead <= 0; ALUSrc <= 0;
			end
			// I type addi
			6'd8:  begin 
			RegDst<=  0;ALUop <=  2'b00 ;Branch <=  0;   
			MemtoReg   <=  0 ;RegWrite   <=  1 ;Jump<=0;
			MemWrite   <=  0 ;MemRead    <=  0 ;  ALUSrc <=  1 ;  
			end
			// I type ori
			6'd13:  begin 
			RegDst<=  0;ALUop <=  2'b11 ;Branch <=  0;   
			MemtoReg   <=  0 ;RegWrite<=  1 ;Jump<=0;
			MemWrite   <=  0 ;MemRead<=  0 ;  ALUSrc<=  1 ;  
			end
			//I type lw
			6'd35:begin  
			RegDst <= 0; ALUop <= 2'b00;Branch<=0;
			MemtoReg <= 1; RegWrite <= 1;Jump<=0;
			MemWrite <= 0; MemRead <= 1; ALUSrc <= 1;
			end
			//I type sw
			6'd43:begin
			RegDst <= 0;  ALUop <= 2'b00;Branch<=0;
			MemtoReg <= 0; RegWrite <= 0;Jump<=0;
			MemWrite <= 1; MemRead <= 0; ALUSrc <= 1;
			end
			//I type beq
			6'd4:begin
			RegDst <= 0; ALUop <= 2'b01;Branch<=1;
			MemtoReg <= 0; RegWrite <= 0;Jump<=0;
			MemWrite <= 0; MemRead <= 0; ALUSrc <= 0;
			end
			//I type bne
			/*
			6'd5:begin
			RegDst <= 0; ALUop <= 2'b01;Branch<=1;
			MemtoReg <= 0; RegWrite <= 0;Jump<=0;
			MemWrite <= 0; MemRead <= 0; ALUSrc <= 0;
			end*/
			//J type
			6'd2:begin
			RegDst <= 0;  ALUop <= 0;Branch<=0;
			MemtoReg <= 0; RegWrite <= 0;Jump<=1;
			MemWrite <= 0; MemRead <= 0; ALUSrc <= 0;
			end
			default:begin
				RegDst <= 0; ALUop <= 0;Branch<=0;
				MemtoReg <= 0; RegWrite <= 0;Jump<=0;
				MemWrite <= 0; MemRead <= 0; ALUSrc <= 0;
		  end
    	endcase 
    end
endmodule
