`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 10:30:04 PM
// Design Name: 
// Module Name: RF
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


module RF(clk, reset, RegWre, Read_Reg1, Read_Reg2, Write_Reg, Write_Data, Read_Data1, Read_Data2);
    input clk;
    input reset;
    input RegWre;
    input [4:0] Read_Reg1;
    input [4:0] Read_Reg2;
    input [4:0] Write_Reg;
    input [31:0] Write_Data;
    output [31:0] Read_Data1;
    output [31:0] Read_Data2;


    reg [31:0] RegFile[0:31];
    integer i;
    assign Read_Data1 = (Read_Reg1 == 0) ? 0 : RegFile[Read_Reg1];
    assign Read_Data2 = (Read_Reg2 == 0) ? 0 : RegFile[Read_Reg2];  
    initial begin
    for (i = 0; i < 32; i = i + 1) 
        RegFile[i] = 0;
    end
    always @ (negedge clk or negedge reset)
    begin
        if(reset == 0)
        begin
            for(i = 1; i < 32; i = i + 1)
                RegFile[Write_Reg] <= 0;
        end
        else if(RegWre == 1 && Write_Reg != 0) 
            RegFile[Write_Reg] <= Write_Data;  
    end
endmodule
