`timescale 1ns / 1ps

module pc_add(addr1,addr2,out_addr);
 input [31:0] addr1,addr2;
 output [31:0] out_addr;
 assign out_addr = addr1+addr2;
endmodule


module and_unit(
input a,b,
output result
    );
  assign result=a&b;        
endmodule

module left_shift2#(parameter bit=32)(
input[bit-1:0]imme_in,
output [bit-1:0]shift_out
    );
    assign shift_out=imme_in<<2;
endmodule

module signed_extend(
input[15:0]imme_in,
output [31:0]extend_out
    );
    assign extend_out=imme_in[15]?	{{16{1'b1}},imme_in}:	{{16{1'b0}},imme_in};
endmodule

module mux_2x1#(parameter bit=32)(
input[bit-1:0]in_1,in_2,
input sel,
output [bit-1:0]mux_out
    );
    assign mux_out=sel?in_2 :in_1 ;
endmodule

// Asynchronous active-low reset synchronizer with 2-stage flip-flop for glitch-free release
module rstn_sync(
input clk,rstn,
output rstn_out
    );
    reg [1:0]rstn_reg;
    assign rstn_out=rstn_reg[1];
   always@(posedge clk or negedge rstn)
		if(!rstn)
			rstn_reg<=0;
		else
  			rstn_reg<={rstn_reg[0],1'b1};
endmodule