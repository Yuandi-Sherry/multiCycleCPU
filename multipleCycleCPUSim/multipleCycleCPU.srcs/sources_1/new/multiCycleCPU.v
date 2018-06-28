`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 11:14:02 PM
// Design Name: 
// Module Name: multiCycleCPU
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


module multiCycleCPU(CLK, RST, PCout, nextPCout, opout,INSout,PCIRout,
    ReadData1out, ReadData2out, ADRout, BDRout,inAout, inBout,
    resultout,ALUDRout,opout,rsout, rdout,rtout,saout, writeRegout,
    immediateout,jumpout,signout,zeroout,PCWreout, InsMemRWout, IRWreout,WrRegDSrcout, 
    RegWreout,ALUSrcAout, ALUSrcBout, 
    mRDout, mWRout, DBDataSrcout,ExtSelout,
    PCSrcout,RegDstout,ALUOpout, stateout,DBout, 
    PC4out,extendOutputout, ExtendSaout,DMDataOutout,writeDataout, toDBDRout);
input CLK, RST;
output [31:0] PCout, nextPCout,INSout,PCIRout,ReadData1out, ReadData2out, ADRout, BDRout,inAout, inBout,
    resultout,ALUDRout;
output [5:0] opout;
output [4:0] rsout, rdout,rtout,saout, writeRegout;
output [15:0] immediateout;
output [25:0] jumpout;
output signout,zeroout,PCWreout, InsMemRWout, IRWreout,WrRegDSrcout, 
      RegWreout,ALUSrcAout, ALUSrcBout, 
      mRDout, mWRout, DBDataSrcout,ExtSelout;

output [1:0] PCSrcout,RegDstout;
output [2:0] ALUOpout, stateout;
output [31:0] DBout, PC4out,extendOutputout, ExtendSaout,DMDataOutout,writeDataout, toDBDRout;




// IF:PCÊä³öºÍÊäÈë
wire [31:0] PC, nextPC, PCIR, INS,toDBDR;

// ID
wire [5:0] op;
wire [4:0] rs, rt, rd, sa,writeReg;
wire [15:0] immediate;
wire [25:0] jump;

// EXE
wire [31:0] ReadData1, ReadData2, ADRoutput, BDRoutput,inA, inB;
wire sign, zero;
wire [31:0] result, ALUDRoutput;  

// ËùÓÐ¿ØÖÆÐÅºÅ
wire PCWre, InsMemRW, IRWre,WrRegDSrc, 
      RegWre,ALUSrcA, ALUSrcB, 
      mRD, mWR, DBDataSrc,ExtSel;
wire [1:0] PCSrc,RegDst;
wire [2:0] ALUOp, state;
wire [31:0] DB, PC4,extendOutput, ExtendSa,DMDataOut,writeData;

// (clk, reset, PCWre,nextPC, IAddr);
PC myPC(CLK, RST, PCWre,nextPC, PC);
//  InsMem(InsMemRW,IAddr,IDataOut);
InsMem myInsMem(InsMemRW,PC,PCIR);
// (CLK,IRWre,IDataIn,IDataOut)
IR myIR(CLK,IRWre,PCIR,INS);
CU myCU(CLK, RST, zero, sign, op,
    PCWre, PCSrc, 
    InsMemRW, IRWre, 
    WrRegDSrc, RegDst, RegWre, 
    ALUOp, ALUSrcA, ALUSrcB,mRD, mWR, DBDataSrc,ExtSel,state);
ALU myALU(inA, inB, ALUOp, result, zero, sign);
MUX_32bits_2to1 myWriteDataMUX(WrRegDSrc, PC4, DB, writeData);
MUX_5bit_4to1 myWriteRegMUX(RegDst, rt, rd, writeReg);
RF myRF(CLK, RST, RegWre, rs, rt, writeReg, writeData, ReadData1, ReadData2);
DR myADR(CLK, ReadData1, ADRoutput);
DR myBDR(CLK, ReadData2, BDRoutput);

MUX_32bits_2to1 myALUA(ALUSrcA, ADRoutput, ExtendSa, inA);
MUX_32bits_2to1 myALUB(ALUSrcB, BDRoutput, extendOutput, inB);
DR myALUDR(CLK, result, ALUDRoutput);
DataMem myDM(CLK, mRD, mWR, ALUDRoutput, BDRoutput, DMDataOut);
Extend myExtend(immediate, ExtSel, extendOutput);
ExtendSa myExtendSa(sa, ExtendSa);
MUX_32bits_2to1 myDBMUX(DBDataSrc, result, DMDataOut, toDBDR);
DR myDBDR(CLK, toDBDR, DB);
nextPC myNextPC(RST,PCSrc,PC, extendOutput,jump,ReadData1, PC4, nextPC);
assign op = INS[31:26];
assign rs = INS[25:21];
assign rt = INS[20:16];
assign rd = INS[15:11];
assign sa = INS[10:6];
assign immediate = INS[15:0];
assign jump = INS[25:0];


//Êä³ö¸³Öµ
assign PCout = PC;
assign nextPCout = nextPC;
assign opout = op;
assign INSout = INS;
assign PCIRout = PCIR;
assign ReadData1out = ReadData1;
assign ReadData2out = ReadData2;
assign ADRout = ADRoutput;
assign BDRout = BDRoutput;
assign inAout = inA;
assign inBout = inB;
assign resultout = result;
assign ALUDRout = ALUDRoutput;
assign rsout = rs;
assign rdout = rd;
assign rtout = rt;
assign saout = sa;
assign writeRegout = writeReg;
assign immediateout = immediate;
assign jumpout = jump;

assign signout = sign;
assign zeroout = zero;
assign PCWreout = PCWre;
assign InsMemRWout = InsMemRW;
assign IRWreout = IRWre;
assign WrRegDSrcout = WrRegDSrc;
assign RegWreout = RegWre;
assign ALUSrcAout = ALUSrcA;
assign ALUSrcBout = ALUSrcB;
assign mRDout = mRD;
assign mWRout = mWRout;
assign DBDataSrcout = DBDataSrc;
assign ExtSelout = ExtSel;

assign PCSrcout = PCSrc;
assign RegDstout = RegDst;
assign ALUOpout = ALUOp;
assign stateout = state;
assign DBout = DB;
assign PC4out = PC4;
assign extendOutputout = extendOutput;
assign ExtendSaout = ExtendSa;
assign DMDataOutout = DMDataOut;
assign writeDataout = writeData;
assign toDBDRout = toDBDR;
endmodule
