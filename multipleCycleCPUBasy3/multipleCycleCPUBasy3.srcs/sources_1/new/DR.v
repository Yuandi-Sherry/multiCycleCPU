`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 10:33:30 PM
// Design Name: 
// Module Name: DR
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


module DR(CLK, DataIn, DataOut);
input CLK;
input [31:0] DataIn;
output reg [31:0] DataOut;
reg [31:0] DR;
initial begin
    DR = 0;
end

always @(negedge CLK) 
begin
    DR <= DataIn;
end

always @(posedge CLK)
begin
    DataOut <= DR;
end
endmodule
