`timescale 1ns / 1ps

module mips_cpu(
input clk,rstn_in,
output [31:0]pc,
output [31:0] Instruction
    );    
    wire rstn;
    wire [31:0]pc,pc_add_4,pc_next,pc_jump,pc_mux1,pc_branch;
    wire pc_mux_sel;
    
    wire [31:0] Instruction;
    wire RegDst,Branch,MemtoReg,ALUSrc,RegWrite,MemWrite,MemRead,Jump;
	wire [1:0] ALUop;  
    wire Zero;
    wire [4:0]Write_register;
    wire [31:0] Regsiter_Data1,Regsiter_Data2;
    wire [31:0] Write_Data;
    wire [31:0]extend_out,extend_out_shift;
    wire [31:0] ALU_Data2,ALU_Result;
	wire[3:0]ALUctrl;
    rstn_sync rstn_sync(clk,rstn_in,rstn);
    //PC////////////////////
    programcounter programcounter(clk,rstn,pc_next,pc);
    pc_add4  pc_add4(pc,pc_add_4);
    left_shift2 pc_branch_shift(extend_out,extend_out_shift);
    pc_add pc_add(pc_add_4,extend_out_shift,pc_branch);
    and_unit and_unit(Branch,Zero,pc_mux_sel);
    mux_2x1 mux_pc1(pc_add_4,pc_branch,pc_mux_sel,pc_mux1);
    //left_shift2 pc_jump_shift({6'b000000,Instruction[25:0]},{6'b000000,pc_jump[27:0]});
    assign pc_jump={pc_add_4[31:28],Instruction[25:0],2'b00};
    mux_2x1 mux_pc2(pc_mux1,pc_jump,Jump,pc_next);
    // ID /////////////////////////////
    control_unit control_unit(Instruction[31:26],RegDst,Branch,MemtoReg,ALUSrc,RegWrite,MemWrite,MemRead,Jump,ALUop);
    Instruction_Memory Inst_Mem(rstn,pc,Instruction);
    //  REG  //////////////////////////////////////

    mux_2x1 #( .bit(5)) mux_Write_register(Instruction[20:16],Instruction[15:11],RegDst,Write_register);
    Register_Memory Reg_Mem(clk,rstn,RegWrite,Instruction[25:21],Instruction[20:16],Write_register,Write_Data,Regsiter_Data1,Regsiter_Data2);
    signed_extend signed_extend(Instruction[15:0],extend_out);
    //  ALU  //////////////////////////////////////////////
    

    mux_2x1 mux_alu(Regsiter_Data2,extend_out,ALUSrc,ALU_Data2);
    alu_control alu_control(ALUop,Instruction[5:0],ALUctrl);
    alu ALU(Regsiter_Data1,ALU_Data2,ALUctrl,ALU_Result,Zero);
    //  MEM////////////////
    
    wire [31:0]Mem_Read_Data;
    Data_Memory Data_Mem(clk,rstn,MemWrite,MemRead,ALU_Result,Regsiter_Data2,Mem_Read_Data);
    mux_2x1 mux_MemtoReg(ALU_Result,Mem_Read_Data,MemtoReg,Write_Data);
    
endmodule

