module imem(
    input clk,//ʱ��
    input imemsrc,//��ȡָ
    input [31:0] pc,//pc�ź�
    output reg [31:0] inst//ָ��
    );
    reg [31:0] temp;//�м�����洢��ַ���
    reg [31:0] ins[0:1023];//ָ��Ĵ���ģ��
    
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
