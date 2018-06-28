`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 10:31:49 PM
// Design Name: 
// Module Name: Extend
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


module Extend(immediate, ExtSel, DataOut);
    input [15:0] immediate;
    input ExtSel;
    output [31:0] DataOut;
    
    assign DataOut[15:0] = immediate[15:0];
    assign DataOut[31:16] = (ExtSel == 1) ? ((immediate[15] == 1) ? 16'hFFFF: 16'h0000):16'h0000;
endmodule
