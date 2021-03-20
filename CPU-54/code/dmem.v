`timescale 1ns / 1ps
module dmem(
    input clk,//时钟
    input dmemsrc,//可写
    input [1:0]dmem_inchoice,
    input [2:0]dmem_outchoice,
    input [31:0] addr,//地址
    input [31:0] data_in,//输入
    output reg [31:0] data_out//输出
    );
    wire [7:0]Addr;
    assign Addr = addr[7:0];
    wire [7:0]lh_lb;
    reg [7:0] num [0:1023];//寄存器  
    assign lh_lb = num[Addr];
    always@(posedge clk) 
    begin
        case(dmem_outchoice)
        3'b000:data_out = {num[Addr],num[Addr+1],num[Addr+2],num[Addr+3]};
        3'b001:data_out = {{16{lh_lb[7]}},num[Addr],num[Addr+1]};
        3'b010:data_out = {{16{1'b0}},num[Addr],num[Addr+1]};
        3'b011:data_out = {{24{lh_lb[7]}},num[Addr]};
        3'b100:data_out = {{24{1'b0}},num[Addr]};
        endcase
        if(dmemsrc==1'b1) //可写
        begin
            case (dmem_inchoice)
            2'b10:num[Addr]<=data_in[7:0];
            2'b01:
            begin
                num[Addr]<=data_in[15:8];
                num[Addr+1]<=data_in[7:0];
            end
            2'b00:
            begin
                num[Addr]<=data_in[31:24];
                num[Addr+1]<=data_in[23:16];
                num[Addr+2]<=data_in[15:8];
                num[Addr+3]<=data_in[7:0];
            end
            endcase
        end
    else 
        num[Addr]<=num[Addr];
    end
endmodule

