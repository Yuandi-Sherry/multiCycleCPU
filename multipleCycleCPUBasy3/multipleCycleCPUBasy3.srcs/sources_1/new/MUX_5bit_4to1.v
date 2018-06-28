`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 10:25:47 PM
// Design Name: 
// Module Name: MUX_5bit_4to1
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


module MUX_5bit_4to1(RegDst, rt, rd, WriteReg);
input [1:0] RegDst;
input [4:0] rt, rd;
output [4:0] WriteReg;

assign WriteReg = (RegDst == 2'b00) ? 5'b11111 : (RegDst == 2'b01) ? rt : rd;

endmodule
