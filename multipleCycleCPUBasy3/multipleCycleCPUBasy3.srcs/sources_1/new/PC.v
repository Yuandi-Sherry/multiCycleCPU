`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 02:01:17 PM
// Design Name: 
// Module Name: PC
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

module PC(clk, reset, PCWre,nextPC, IAddr);
    input clk;
    input reset;
    input PCWre;
    input [31:0] nextPC;
    output reg [31:0] IAddr; // current PC address

    always@(posedge clk or negedge reset)
    begin
        if(reset == 0) 
            IAddr <= 0;
        else if (PCWre == 1) 
            IAddr <= nextPC;
    end
endmodule
