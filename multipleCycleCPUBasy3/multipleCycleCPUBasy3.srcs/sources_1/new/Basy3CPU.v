`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/19 14:39:58
// Design Name: 
// Module Name: Basy3CPU
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


module Basy3CPU(CLK,Reset,Key,Selector,a_to_g,an,dp);
input CLK,Reset,Key;
input [1:0] Selector;
output [6:0] a_to_g;
output [3:0] an;
output dp;

wire CLK190,CLK3,State,Led;
wire [31:0] ReadData1, ReadData2, curPC, Result,InsOut,nextPC;
wire [5:0] opCode;
wire [4:0] Rs,Rt,Rd,Sa;
wire [15:0] Immediate;
wire [25:0] Address;
wire [31:0] InA,InB;
wire [2:0] ALU;
wire Zero,Sign;
wire [31:0] DataOut;
wire [15:0] Out;

clk_div myclock(.CLK(CLK),.Reset(Reset),.CLK190(CLK190),.CLK3(CLK3));
manualClock mykey(.CLK(CLK190),.Key(Key),.Led(Led));
//module multiCycleCPU(CLK, RST, PCout, nextPCout,ReadData1out, ReadData2out,resultout,rsdout,rtout,writeDataout);
multiCycleCPU  myCPU(.CLK(Led),.RST(Reset),.PCout(curPC),.nextPCout(nextPC), .ReadData1out(ReadData1),.ReadData2out(ReadData2),.rsout(Rs),.rtout(Rt),.resultout(Result),.writeDataout(DataOut));
//module SingleCycleCPU(CLK,Reset,curPC,nextPC,ReadData1,ReadData2,Rs,Rt,Rd,Sa,Result,DataOut);
SelectDisplay myshift(.CLK(CLK3),.Reset(Reset),.Selector(Selector),.PC(curPC[7:0]),.NextPC(nextPC),.Rs(Rs),.Rt(Rt),.ReadData1(ReadData1[7:0]),.ReadData2(ReadData2[7:0]),.Result(Result[7:0]),.DataOut(DataOut[7:0]),.Out(Out));
display mymux(.CLK190(CLK190),.Reset(Reset),.Out(Out),.a_to_g(a_to_g),.an(an),.dp(dp));

endmodule

