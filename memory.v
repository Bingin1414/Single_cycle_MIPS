`timescale 1ns / 1ps

module Instruction_Memory(
input rstn,
input [31:0]addr_in,
output [31:0]instruction_out
    );
    reg [31:0]Rom[0:31];//need initial by user
    assign instruction_out=Rom[addr_in[6:2]];//[6:2] becsause only have 32 rom data to read
    																	//and pc+4 so ingnor addr[1:0]

//{{6'd4},{5'd1},{5'd2},{16'd2}}  use after function work						
//{{6'd8},{5'd0},{5'd1},{16'd8}}  use after function work
	always@(negedge rstn)begin
	if(!rstn)
    Rom[5'h00]<=32'h20010008;//addi $1,$0,8 		$1=8
    Rom[5'h01]<=32'h3402000C;//ori $2,$0,12 		$2=12
    Rom[5'h02]<=32'h00221820;//add $3,$1,$2 		$3=20
    Rom[5'h03]<=32'h00412022;//sub $4,$2,$1 		$4=4
    Rom[5'h04]<=32'h00222824;//and $5,$1,$2		$5=8
    Rom[5'h05]<=32'h00223025;//or $6,$1,$2			$6=12
    Rom[5'h06]<={{6'd4},{5'd5},{5'd1},{16'd2}};//32'h10220002;// beq $1,$5,2
    Rom[5'h07]<=32'hXXXXXXXX;
    Rom[5'h08]<=32'hXXXXXXXX;
    Rom[5'h09]<=32'h14220002;//bne $1,$2,2
    Rom[5'h0A]<=32'h0800000D;// J 0D 
    Rom[5'h0B]<=32'hXXXXXXXX;
    Rom[5'h0C]<=32'hXXXXXXXX;
    Rom[5'h0D]<=32'hAD02000A;// sw $2 10($8) memory[$8+10]=12
    Rom[5'h0E]<=32'h8D04000A;//lw $4 10($8) 				$4=12
    Rom[5'h0F]<=32'h10440003;//beq $2,$4,3
    Rom[5'h10]<=32'hXXXXXXXX;
    Rom[5'h11]<=32'hXXXXXXXX;
    Rom[5'h12]<=32'hXXXXXXXX;
    Rom[5'h13]<=32'h30470009;//andi $2,9,$7
    Rom[5'h14]<=32'hXXXXXXXX;
    Rom[5'h15]<=32'hXXXXXXXX;
    Rom[5'h16]<=32'hXXXXXXXX;
    Rom[5'h17]<=32'hXXXXXXXX;
    Rom[5'h18]<=32'hXXXXXXXX;
    Rom[5'h19]<=32'hXXXXXXXX;
    Rom[5'h1A]<=32'hXXXXXXXX;
    Rom[5'h1B]<=32'hXXXXXXXX;
    Rom[5'h1C]<=32'hXXXXXXXX;
    Rom[5'h1D]<=32'hXXXXXXXX;
    Rom[5'h1E]<=32'hXXXXXXXX;
    Rom[5'h1F]<=32'hXXXXXXXX;
end
endmodule

module Register_Memory(
 input clk,rstn,
 input RegWrite,
input [4:0] read_registers1,read_registers2,write_registers,
 input [31:0] write_data,
 output [31:0] read_data1,read_data2
  );
  integer i;
 reg [31:0] register[31:0] ;

 assign read_data1 = register[read_registers1];
 assign read_data2 = register[read_registers2];

 always @(posedge clk or negedge rstn) begin
    	if(!rstn)
    		for(i = 0;i < 32;i = i + 1)	register[i] <= 0;
		else if(RegWrite) 
			register[write_registers] <= write_data;//RegWire
 end

endmodule

module Data_Memory(
 input clk,rstn,
 input MemWrite,MemRead,
input [31:0] addr,
 input [31:0] write_data,
 output  [31:0] read_data
  );
    integer i;
     reg [31:0] ram[31:0] ;
     assign read_data = ram[addr];
   always @(posedge clk or negedge rstn) begin
    	if(!rstn)
    		for(i = 0;i < 32;i = i + 1)	ram[i] <= 0;
		else if(MemWrite) 
			ram[addr] <= write_data;
 end
  
  
endmodule