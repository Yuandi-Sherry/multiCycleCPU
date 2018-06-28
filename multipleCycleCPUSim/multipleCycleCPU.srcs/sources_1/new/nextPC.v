`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 09:42:50 PM
// Design Name: 
// Module Name: nextPC
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


module nextPC(reset,PCSrc,currentPC, immediate,jump,readData1, PC4, IAddr);
    input  reset;
    // receive selection signal
    input [1:0] PCSrc;
    // current PCaddress, for 00:pc = pc + 4
    input [31:0] currentPC;
    // conditional, for 01: pc = pc + 4 + immediate*4
    input [31:0] immediate; 
    input [25:0] jump;
    input [31:0] readData1;
    output reg [31:0] PC4;
    output reg [31:0] IAddr;
    
    always @ (reset or PCSrc or currentPC or immediate)
    begin
        if(reset == 0)
            IAddr = 0;
        else
        begin
            case (PCSrc) 
                2'b00:
                    IAddr = currentPC + 4;
                2'b01: // pc<－pc+4+(sign-extend)immediate
                    IAddr = currentPC + 4 + (immediate<<2);
                2'b10:
                    IAddr = readData1;
                2'b11:
                begin // pc<－{(pc+4)[31:28],addr[27:2],2'b00}
                    IAddr[31:28] = currentPC[31:28];
                    IAddr[27:2] = jump; 
                    IAddr[1:0] = 0;
                end 
                default:
                    IAddr = 8'hFFFFFFFF;
            endcase
            PC4 = currentPC + 4;
        end
    end
    
endmodule

