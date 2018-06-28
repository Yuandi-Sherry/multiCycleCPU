`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 11:08:50 PM
// Design Name: 
// Module Name: MUX_32bits_2to1
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


module MUX_32bits_2to1(signal, DataIn1, DataIn2, DataOut);
input signal;
input [31:0] DataIn1, DataIn2;
output [31:0] DataOut;

assign DataOut = (signal == 0) ? DataIn1 : DataIn2;
endmodule
