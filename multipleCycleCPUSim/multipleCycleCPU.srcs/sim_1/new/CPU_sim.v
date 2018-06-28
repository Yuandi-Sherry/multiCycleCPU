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

    
//  multiCycleCPU(CLK, RST, PCout, nextPCout);
multiCycleCPU cpu(
    .CLK(CLK),
    .RST(Reset),
    .PCout(curPC),
    .nextPCout(nextPC),
    .opout(op),
    .INSout(INS),
    .PCIRout(IMIR),
    .ReadData1out(ReadData1),
    .ReadData2out(ReadData2), 
    .ADRout(ADRoutput), 
    .BDRout(BDRoutput),
    .inAout(inA), 
    .inBout(inB),
    .resultout(result),
    .ALUDRout(ALUDRoutput),
    .rsout(rs), 
    .rdout(rd),
    .rtout(rt),
    .saout(sa), 
    .writeRegout(writeReg),
    .immediateout(immediate),
    .jumpout(jump),
    .signout(sign),
    .zeroout(zero),
    .PCWreout(PCWre), 
    .InsMemRWout(InsMemRW), 
    .IRWreout(IRWre),
    .WrRegDSrcout(WrRegDSrc), 
    .RegWreout(RegWre),
    .ALUSrcAout(ALUSrcA), 
    .ALUSrcBout(ALUSrcB), 
    .mRDout(mRD), 
    .mWRout(mWR), 
    .DBDataSrcout(DBDataSrc),
    .ExtSelout(ExtSel),
    .PCSrcout(PCSrc),
    .RegDstout(RegDst),
    .ALUOpout(ALUOp), 
    .stateout(state),
    .DBout(DB), 
    .PC4out(PC4),
    .extendOutputout(extendOutput), 
    .ExtendSaout(ExtendSa),
    .DMDataOutout(DMDataOut),
    .writeDataout(writeData),
    .toDBDRout(DBDR));
always #50 CLK=~CLK;    
initial begin
    CLK = 0;
    Reset = 0;
    //assign curPC = 0;
    #150;
     Reset=1;
end
    
endmodule

