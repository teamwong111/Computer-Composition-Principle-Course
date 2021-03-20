`timescale 1ns / 1ps
module regfile(
    input clk, //�½���д������
    input rst, //�ߵ�ƽʱȫ���Ĵ�������
    input [4:0] raddr1, //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] raddr2, //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] waddr, //д�Ĵ����ĵ�ַ
    input [31:0] wdata, //д�Ĵ������ݣ������� clk �½���ʱ��д��
    input regfilesrc,
    output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ������������
    output [31:0] rdata2 //raddr2 ����Ӧ�Ĵ������������
    );
    reg [31:0] array_reg [31:0]; //�Ĵ���
    
    //д�Ĵ���
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
        
    //�������
    assign rdata1 = array_reg[raddr1];
    assign rdata2 = array_reg[raddr2];
endmodule

 