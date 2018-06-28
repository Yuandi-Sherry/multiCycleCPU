`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 10:32:30 PM
// Design Name: 
// Module Name: ExtendSa
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


module ExtendSa(Sa, ExtendSa);
input [4:0] Sa;
output [31:0] ExtendSa;

assign ExtendSa[31:5] = 0;
assign ExtendSa = Sa;
endmodule
