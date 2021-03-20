module imem(
    input clk,//时钟
    input imemsrc,//可取指
    input [31:0] pc,//pc信号
    output reg [31:0] inst//指令
    );
    reg [31:0] temp;//中间变量存储地址输出
    reg [31:0] ins[0:1023];//指令寄存器模块
    
    initial 
    begin
        $readmemh("D:/cputest/14_jal.hex.txt", ins);
    end
    
    always @(pc or imemsrc) 
    begin 
        // Read Instruction
        if (imemsrc) begin
            temp = ins[pc];
        end
    end
    
    always @(posedge clk) 
    begin
        if(imemsrc)
            inst <= temp;
    end
endmodule
