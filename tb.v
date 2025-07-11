`timescale 1ns / 1ps

module tb;
reg clk,reset;
wire [31:0]pc,Instruction;
    /*
    wire [31:0] Inst,NEXTADDR,ALU_R,Qb,Qa,Addr,D;
   
    wire [31:0]Result,PCadd4,EXTIMM,InstL2,EXTIMML2,Y,Dout,mux4x32_2,R;
    wire Z,Regrt,Se,Wreg,Aluqb,Reg2reg,Cout,Wmem;
    wire [3:0]Aluc;
    wire [1:0]Pcsrc;
    wire [4:0]Wr;
*/

mips_cpu dut(
.clk(clk),
.rstn_in(reset),
.pc(pc),
.Instruction(Instruction));

    initial begin        
	clk=0;
	reset=0;
         #5
		reset<=1;
    end
    always #25 clk=~clk;
    endmodule