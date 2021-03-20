`timescale 1ns / 1ps
module div_tb;
    reg [31:0] dividend;
    reg [31:0] divisor;
    reg start;
    reg clock;
    reg reset;
    wire [31:0] divu_q;
    wire [31:0] divu_r;
    wire [31:0] div_q;
    wire [31:0] div_r;
    wire busy;
    DIVU U1(.dividend(dividend),.divisor(divisor),.start(start),.clock(clock),.reset(reset),.q(divu_q),.r(divu_r),.busy(busy));
    DIV U2(.dividend(dividend),.divisor(divisor),.start(start),.clock(clock),.reset(reset),.q(div_q),.r(div_r),.busy(busy));
    initial
    begin
        reset = 1;
        clock = 0;
        start = 0;
        dividend = 32'b11111111_11111111_11111111_11111111;
        divisor = 32'b10;
        # 10
        reset = 0;
        # 10
        start = 1;
        # 10
        start = 0;
        # 400
        reset = 1;
        dividend = 32'b10101010_10101010_10101010_10101010;
        divisor = 32'b01010101_01010101_01010101_01010101;
        # 10
        reset = 0;
        # 10
        start = 1;
        # 10
        start = 0;
    end
    always
    #5 clock <= ~clock;
endmodule
