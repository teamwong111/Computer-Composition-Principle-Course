`timescale 1ns / 1ps
module sccomp_dataflow(
    input clk_in, //ʱ��
    input reset,  //��λ
    input pc_reset,
    output [31:0] inst, //32λָ��
    output [31:0] pc,  //ָ���ַ
    output imemsrc
    );
    wire dmemsrc;
    wire [1:0]dmem_inchoice;
    wire [2:0]dmem_outchoice;
    wire [31:0]addr;
    wire [31:0]data_in;
    wire [31:0]data_out;
    
    imem imem(~clk_in, imemsrc, ((pc - 32'h00400000)/4), inst);//���PC�����ָ��

    cpu sccpu(clk_in, reset, pc_reset, inst, pc, imemsrc,      dmemsrc, dmem_inchoice, dmem_outchoice, addr, data_in, data_out); //CPU��ع���
    
    dmem dmem(~clk_in, dmemsrc, dmem_inchoice, dmem_outchoice, addr - 32'h10010000, data_in, data_out);//                
endmodule