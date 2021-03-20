module pcreg(
    input clk,  
    input rst,  //高电平时将PC寄存器清零
    input [31:0] data_in,
    input pcsrc,
    output reg [31:0] data_out
    );
    always @(posedge rst or posedge clk)
    begin
    if(rst)
        data_out <= 32'b0000_0000_0100_0000_0000_0000_0000_0000;
    else
    begin
        if(pcsrc)
            data_out <= data_in;
        else
            data_out <= data_out;
    end
    end    
endmodule