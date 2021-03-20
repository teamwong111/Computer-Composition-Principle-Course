`timescale 1ns / 1ps

module cpu_tb();
	reg clk;
	reg rst;
	reg pc_rst;
	wire [31:0] inst;
	wire [31:0] pc;	
	wire imemsrc;
	
	//看控制信号
    wire [2:0]presentstate = uut.sccpu.cpu_controlunit.presentState;
	wire alusrc = uut.sccpu.cpu_controlunit.alusrc;
	wire [4:0]aluchoice = uut.sccpu.cpu_controlunit.aluchoice;
	wire regfilesrc = uut.sccpu.cpu_controlunit.regfilesrc;
	wire hi_losrc = uut.sccpu.cpu_controlunit.hi_losrc;
	wire _imemsrc = uut.sccpu.cpu_controlunit.imemsrc;
	wire [1:0]alu_achoice = uut.sccpu.cpu_controlunit.alu_achoice; 
	wire alu_bchoice = uut.sccpu.cpu_controlunit.alu_bchoice;
	wire rf_addrinchoice = uut.sccpu.cpu_controlunit.rf_addrinchoice;
	wire pcsrc = uut.sccpu.cpu_controlunit.pcsrc;
	wire [1:0]pc_inchoice = uut.sccpu.cpu_controlunit.pc_inchoice;
	wire [2:0]rf_inchoice = uut.sccpu.cpu_controlunit.rf_inchoice;
	wire hi_inchoice = uut.sccpu.cpu_controlunit.hi_inchoice;
	wire lo_inchoice = uut.sccpu.cpu_controlunit.lo_inchoice;
	
	wire [31:0]pc_result = uut.sccpu.cpu_alu.pc_result;
	wire [4:0]rf_addr = uut.sccpu.cpu_ref.waddr;
	
//	//看dmem
//	wire dmemsrc = uut.sccpu.cpu_controlunit.dmemsrc;
//	wire [1:0]dmem_inchoice = uut.sccpu.cpu_controlunit.dmem_inchoice;
//	wire [2:0]dmem_outchocie = uut.sccpu.cpu_controlunit.dmem_outchoice;
	
	//看cp0
	wire mfc0src = uut.sccpu.cpu_controlunit.mfc0src;
    wire mtc0src = uut.sccpu.cpu_controlunit.mtc0src;
    wire exception = uut.sccpu.cpu_controlunit.exception;
    wire _eret = uut.sccpu.cpu_controlunit._eret;
    wire [4:0]cause = uut.sccpu.cpu_controlunit.cause;
//    wire cp0_12 = uut.sccpu.cpu_cp0.cp0[12];
//    wire cp0_13 = uut.sccpu.cpu_cp0.cp0[13];
//    wire cp0_14 = uut.sccpu.cpu_cp0.cp0[14];
//    wire [31:0]exc_addr = uut.sccpu.cpu_cp0.exc_addr;
	
	sccomp_dataflow uut(
	   .clk_in(clk),
	   .reset(rst),
	   .pc_reset(pc_rst),
	   .inst(inst),
	   .pc(pc),
	   .imemsrc(imemsrc)
		);
	integer file_output;
	integer counter;
    initial
    begin
       file_output = $fopen("D:/cpuresult/14_jal.txt");//可根据需要调整
       clk = 0;
       rst = 1;
       pc_rst = 1;
       counter = 0;
       #5;
       rst = 0;	  
       # 20
       pc_rst = 0; 
	end
	
	always 
	begin
	#5;
	clk = ~clk;
	if (clk == 1'b1)
	begin
	if (counter == 4000)
	begin
	   $fclose(file_output);
	end 
	else begin
	    counter = counter + 1;
//	    if(counter % 5 == 2 && counter > 5)
        if(counter % 5 == 2 && counter > 5)
	    begin
	    $fdisplay(file_output,"pc: %h",pc-32'h00400000);
	    $fdisplay(file_output,"instr: %h",uut.inst);
	    $fdisplay(file_output,"regfile0: %h",uut.sccpu.cpu_ref.array_reg[0]);
	    $fdisplay(file_output,"regfile1: %h",uut.sccpu.cpu_ref.array_reg[1]);
	    $fdisplay(file_output,"regfile2: %h",uut.sccpu.cpu_ref.array_reg[2]);
	    $fdisplay(file_output,"regfile3: %h",uut.sccpu.cpu_ref.array_reg[3]);
	    $fdisplay(file_output,"regfile4: %h",uut.sccpu.cpu_ref.array_reg[4]);
	    $fdisplay(file_output,"regfile5: %h",uut.sccpu.cpu_ref.array_reg[5]);
	    $fdisplay(file_output,"regfile6: %h",uut.sccpu.cpu_ref.array_reg[6]);
	    $fdisplay(file_output,"regfile7: %h",uut.sccpu.cpu_ref.array_reg[7]);
	    $fdisplay(file_output,"regfile8: %h",uut.sccpu.cpu_ref.array_reg[8]);
	    $fdisplay(file_output,"regfile9: %h",uut.sccpu.cpu_ref.array_reg[9]);
	    $fdisplay(file_output,"regfile10: %h",uut.sccpu.cpu_ref.array_reg[10]);
	    $fdisplay(file_output,"regfile11: %h",uut.sccpu.cpu_ref.array_reg[11]);
	    $fdisplay(file_output,"regfile12: %h",uut.sccpu.cpu_ref.array_reg[12]);
	    $fdisplay(file_output,"regfile13: %h",uut.sccpu.cpu_ref.array_reg[13]);
	    $fdisplay(file_output,"regfile14: %h",uut.sccpu.cpu_ref.array_reg[14]);
	    $fdisplay(file_output,"regfile15: %h",uut.sccpu.cpu_ref.array_reg[15]);
	    $fdisplay(file_output,"regfile16: %h",uut.sccpu.cpu_ref.array_reg[16]);
	    $fdisplay(file_output,"regfile17: %h",uut.sccpu.cpu_ref.array_reg[17]);
	    $fdisplay(file_output,"regfile18: %h",uut.sccpu.cpu_ref.array_reg[18]);
	    $fdisplay(file_output,"regfile19: %h",uut.sccpu.cpu_ref.array_reg[19]);
	    $fdisplay(file_output,"regfile20: %h",uut.sccpu.cpu_ref.array_reg[20]);
	    $fdisplay(file_output,"regfile21: %h",uut.sccpu.cpu_ref.array_reg[21]);
	    $fdisplay(file_output,"regfile22: %h",uut.sccpu.cpu_ref.array_reg[22]);
	    $fdisplay(file_output,"regfile23: %h",uut.sccpu.cpu_ref.array_reg[23]);
	    $fdisplay(file_output,"regfile24: %h",uut.sccpu.cpu_ref.array_reg[24]);
	    $fdisplay(file_output,"regfile25: %h",uut.sccpu.cpu_ref.array_reg[25]);
	    $fdisplay(file_output,"regfile26: %h",uut.sccpu.cpu_ref.array_reg[26]);
	    $fdisplay(file_output,"regfile27: %h",uut.sccpu.cpu_ref.array_reg[27]);
	    $fdisplay(file_output,"regfile28: %h",uut.sccpu.cpu_ref.array_reg[28]);
	    $fdisplay(file_output,"regfile29: %h",uut.sccpu.cpu_ref.array_reg[29]);
	    $fdisplay(file_output,"regfile30: %h",uut.sccpu.cpu_ref.array_reg[30]);
	    $fdisplay(file_output,"regfile31: %h",uut.sccpu.cpu_ref.array_reg[31]);
	    end
	   end
	end
	end
endmodule