`timescale 1ns / 1ps
module mult_tb;
    reg clk;
    reg reset;
    reg [31:0]a;
    reg [31:0]b;
    wire [63:0]multu_z;
    wire [63:0]mult_z;
    MULTU U1(.clk(clk),.reset(reset),.a(a),.b(b),.z(multu_z));
    MULT U2(.clk(clk),.reset(reset),.a(a),.b(b),.z(mult_z));
    initial
    begin
        reset = 1;
        clk = 0;
        # 100
        reset = 0;
        a = 0;
        b = 0;
        # 100
        a = 0;
        b = 32'b11111111_11111111_11111111_11111111;
        # 100
        a = 32'b1;
        b = 32'b11111111_11111111_11111111_11111111;
        # 100
        a = 32'b11111111_11111111_11111111_11111111;
        b = 32'b11111111_11111111_11111111_11111111;
        # 100
        a = 32'b10000000_00000000_00000000_00000000;
        b = 32'b10101010_10101010_10101010_10101010;
        # 100
        a = 32'b10101010_10101010_10101010_10101010;
        b = 32'b10000000_00000000_00000000_00000000;
    end
    always
    #10 clk<=~clk;
endmodule
