`timescale 1ns / 1ps

module programcounter(
input clk,rstn,
input[31:0]addr_in,
output reg [31:0]addr_out
    );    
    always@(posedge clk or negedge rstn)
    	if(!rstn)    		addr_out<=32'h0000_0000;
    		else    		addr_out<=addr_in;
endmodule

module pc_add4(
input [31:0]pc,
output [31:0]pc_next_4
    );    
    assign pc_next_4=pc+32'd4;        
endmodule