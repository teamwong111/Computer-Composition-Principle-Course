`timescale 1ns / 1ps
module cpu(
    input clk,//时钟
    input reset,//重置
    input pc_reset,
    input  [31:0] inst,//指令
    output [31:0] pc,//指令地址
    output imemsrc,//是否取指
    
    output dmemsrc,
    output [1:0]dmem_inchoice,
    output [2:0]dmem_outchoice,
    output [31:0]dmem_addrin,
    output [31:0]dmem_in,
    input [31:0]dmem_out
    );
    //alu部分
    wire [31:0]alu_a;
    wire [31:0]alu_b;
    wire [31:0]imm;
    wire [31:0]alupc_in;
    wire alusrc;
    wire [4:0]aluchoice;
    wire [31:0]hi_result;
    wire [31:0]lo_result;
    wire [31:0]result;
    wire [31:0]pc_result;
    
    //refile部分
    wire [4:0]rf_addrin;
    wire [31:0]rf_in;
    wire regfilesrc;
    wire [31:0]rs;
    wire [31:0]rt;
    
    //hi_lo部分
    wire [31:0]hi_in;
    wire [31:0]lo_in;
    wire hi_losrc;
    wire [31:0]hi_out;
    wire [31:0]lo_out;
    
    //pcreg部分
    wire [31:0]pc_in;
    wire pcsrc;
    wire [31:0]pc_out;
    
    //cp0
    wire mfc0;
    wire mtc0;
    wire [31:0]cp0_pc;
    wire [4:0]cp0_addr;
    wire [31:0]cp0_in;
    wire exception;
    wire [4:0]cause;
    wire [31:0]cp0_out;
    wire [31:0]exc_addr;
    
    //选择器部分
    wire [1:0]alu_achoice;
    wire [1:0]alu_bchoice;
    wire [1:0]rf_addrinchoice;
    wire [1:0]pc_inchoice;
    wire [2:0]rf_inchoice;
    wire [1:0]_dmem_inchoice;
    wire [2:0]_dmem_outchoice;
    wire hi_inchoice;
    wire lo_inchoice;
    
    //cpu输出
    wire _imemsrc;
    assign imemsrc = _imemsrc;
    assign pc = pc_out;
    assign dmem_addrin = result;
    assign dmem_in = rt;
    
    wire _dmemsrc;
    assign dmemsrc = _dmemsrc;
    assign dmem_inchoice = _dmem_inchoice;
    assign dmem_outchoice = _dmem_outchoice;
    //指令译码
    controlunit cpu_controlunit(clk, pc_reset, inst, alusrc, aluchoice, regfilesrc, hi_losrc, _imemsrc, pcsrc,
    alu_achoice, alu_bchoice, rf_addrinchoice, pc_inchoice, rf_inchoice, _dmemsrc, _dmem_inchoice, _dmem_outchoice,
    mfc0, mtc0, exception, eret, cause, hi_inchoice, lo_inchoice, rs, rt);
    //选择器
    assign alu_a = alu_achoice==2'b00 ? rs : (alu_achoice==2'b01 ? {{27{1'b0}},rs} : {{27{1'b0}},inst[10:6]});
    assign alu_b = alu_bchoice==2'b00 ? rt : (alu_bchoice==2'b01 ? {{16{inst[15]}},inst[15:0]} : {{16{1'b0}},inst[15:0]});
    assign imm = {{(32 - 18){inst[15]}},inst[15:0],2'b00};
    assign alupc_in = pc_out;
    
    assign rf_addrin = rf_addrinchoice==2'b00 ? inst[15:11] : (rf_addrinchoice==2'b01 ? inst[20:16] : 5'b11111);
    assign rf_in = rf_inchoice==3'b000 ? result : (rf_inchoice==3'b001 ? pc_result : (rf_inchoice==3'b010 ? dmem_out : 
    (rf_inchoice==3'b011 ? lo_result : (rf_inchoice==3'b100 ? cp0_out : (rf_inchoice==3'b101 ? hi_out : lo_out)))));
    
    assign hi_in = hi_inchoice ? rs : hi_result;
    assign lo_in = lo_inchoice ? rs : lo_result;
    
    assign pc_in = pc_inchoice==2'b00 ? pc_result : (pc_inchoice==2'b01 ? {pc_out[31:28],inst[25:0]<<2} : rs);
    
    assign cp0_pc = pc_out;
    assign cp0_addr = inst[15:11];
    assign cp0_in = rt;
    
    //部件
    alu      cpu_alu    (alu_a, alu_b, imm, alupc_in, alusrc, aluchoice,      hi_result, lo_result, result, pc_result);
    regfile  cpu_ref    (~clk, reset, inst[25:21], inst[20:16], rf_addrin, rf_in, regfilesrc,                  rs, rt);
    hi_lo    cpu_hi_lo  (~clk, reset, hi_in, lo_in, hi_losrc,                                          hi_out, lo_out);
    pcreg    cpu_pcreg  (clk, pc_reset, pc_in, pcsrc,                                                          pc_out);
    cp0      cpu_cp0    (~clk, reset, mfc0, mtc0, cp0_pc, cp0_addr, cp0_in, exception, eret, cause, cp0_out, exc_addr);  
endmodule