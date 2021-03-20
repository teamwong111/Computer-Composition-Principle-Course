`timescale 1ns / 1ps
module regfile(
    input clk, //下降沿写入数据
    input rst, //高电平时全部寄存器置零
    input [4:0] raddr1, //所需读取的寄存器的地址
    input [4:0] raddr2, //所需读取的寄存器的地址
    input [4:0] waddr, //写寄存器的地址
    input [31:0] wdata, //写寄存器数据，数据在 clk 下降沿时被写入
    input regfilesrc,
    output [31:0] rdata1, //raddr1 所对应寄存器的输出数据
    output [31:0] rdata2 //raddr2 所对应寄存器的输出数据
    );
    reg [31:0] array_reg [31:0]; //寄存器
    
    //写寄存器
    integer i;    
    always @(posedge clk or posedge rst) 
    begin
        if(rst) 
        begin
            for(i=0;i<32;i=i+1)
               array_reg[i] <= 0;
        end
        else if((waddr!=0)&&regfilesrc==1)
        begin
            array_reg[waddr] <= wdata;
        end
        else
        begin
            array_reg[waddr] <= array_reg[waddr];
        end
    end
        
    //输出数据
    assign rdata1 = array_reg[raddr1];
    assign rdata2 = array_reg[raddr2];
endmodule

 