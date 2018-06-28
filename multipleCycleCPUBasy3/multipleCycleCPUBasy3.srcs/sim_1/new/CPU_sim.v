`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2018 11:13:26 AM
// Design Name: 
// Module Name: CPU_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_sim();
    reg Reset;
    reg CLK;
    // check out signals from CU
    wire [31:0] curPC,nextPC,INS,IMIR;//,WriteData, ReadData1, ReadData2, RegA, RegB, Result, Extend, DataIn, DAddr;
    wire [5:0] op;
    //wire [4:0] sa, WriteReg,rs,rt,rd;

    wire [31:0] ReadData1, ReadData2, ADRoutput, BDRoutput,inA, inB,result,ALUDRoutput;
    wire [4:0] rs, rd, rt, sa, writeReg;
    wire [15:0] immediate;
    wire [25:0] jump;
    wire sign,zero,PCWre, InsMemRW, IRWre,WrRegDSrc, 
      RegWre,ALUSrcA, ALUSrcB, 
      mRD, mWR, DBDataSrc,ExtSel;

    wire [1:0] PCSrc,RegDst;
    wire [2:0] ALUOp, state;
    wire [31:0] DB, PC4,extendOutput, ExtendSa,DMDataOut, writeData, DBDR;

// multiCycleCPU(CLK, RST, PCout, nextPCout,ReadData1out, ReadData2out,resultout,rsout,rtout,writeDataout);
//  multiCycleCPU(CLK, RST, PCout, nextPCout);
multiCycleCPU cpu(
    .CLK(CLK),
    .RST(Reset),
    .PCout(curPC),
    .nextPCout(nextPC),
    .ReadData1out(ReadData1),
    .ReadData2out(ReadData2), 
    .resultout(result),
    .rsout(rs), 
    .rtout(rt),
    .writeDataout(writeData));
always #50 CLK=~CLK;    
initial begin
    CLK = 0;
    Reset = 0;
    //assign curPC = 0;
    #150;
     Reset=1;
end
    
endmodule

