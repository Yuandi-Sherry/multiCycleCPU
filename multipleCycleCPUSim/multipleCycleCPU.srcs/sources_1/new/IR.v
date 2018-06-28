`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 02:02:26 PM
// Design Name: 
// Module Name: IR
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


module IR(CLK,IRWre,IDataIn,IDataOut);    
    input CLK,IRWre;
    input [31:0] IDataIn;
    output reg [31:0] IDataOut;
    
    reg [31:0] IR;
    initial 
    begin
       IR = 0;
    end
    always@(negedge CLK)
    begin
        if(IRWre == 1) // дʹ��
            IR <= IDataIn;
    end
    
    always@(posedge CLK) // ��ȡ��ǰָ��
    begin
        $display("output");
        IDataOut <= IR;
    end
endmodule

