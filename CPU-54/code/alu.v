`timescale 1ns / 1ps
module alu( 
    input [31:0] A,
    input [31:0] B,
    input [31:0] imm,
    input [31:0] pc_in,
    input alusrc,
    input [4:0] aluchoice,
    output reg [31:0] hi_result,
    output reg [31:0] lo_result,
    output reg [31:0] result,
    output reg [31:0] pc_result
    );
    integer i; // CLZ用
    integer j;
    integer max;
    
    always @(*) 
    begin
        if(alusrc)
        begin
        pc_result <= pc_in + 32'b100;
        case(aluchoice)
            5'b00000: result <= A + B;                                    //ADDU
            5'b00001: result <= $signed(A) + $signed(B);                //ADD
            5'b00010: result <= A - B;                                    //SUBU
            5'b00011: result <= $signed(A) - $signed(B);               //SUB
            5'b00100: result <= A & B;                                    //AND
            5'b00101: result <= A | B;                                    //OR
            5'b00110: result <= A ^ B;                                    //XOR
            5'b00111: result <= ~(A|B);                                   //NOR
            5'b01000: result <= {B[15:0], 16'b0};                         //LUI
            5'b01001: result <= (A < B) ? 1 : 0;                          //SLTU
            5'b01010: result <= ($signed(A)<$signed(B)) ? 1 : 0;       //SLT
            5'b01011: result <= $signed(B) >>> A;                        //SRA 向右算术移位
            5'b01100: result <= B >> A;                                  //SRL 向右逻辑移位
            5'b01101: result <= B << A;                                  //SLL SLR
            5'b01110: pc_result <= (B == A) ? pc_in + imm + 32'b100 : pc_in + 32'b100;//BEQ 跳转地址
            5'b01111: pc_result <= (B != A) ? pc_in + imm + 32'b100 : pc_in + 32'b100;//BNE 跳转地址
            5'b10000: pc_result <= ($signed(A)>=0) ? pc_in + imm + 32'b100 : pc_in + 32'b100; //BGEZ 生成跳转地址
            5'b10001: {hi_result, lo_result} <= {$signed(A) % $signed(B), $signed(A) / $signed(B)};//DIV
            5'b10010: {hi_result, lo_result} <= {A % B, A / B};//DIVU
            5'b10011: {hi_result, lo_result} <= $signed(A) * $signed(B);// MUL
            5'b10100: {hi_result, lo_result} <= A * B; //MULTU
            5'b10101://CLZ
            begin
                j = 0;
                max = 0;
                for(i = 31; i >= 0;i = i-1) 
                begin
                    if(A[i]==1'b1) 
                        j = 1;
                    if(!j) 
                        max = max + 1;
                end
                result <= max;
            end 
        endcase
        end
    end
endmodule
