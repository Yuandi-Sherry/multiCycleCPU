`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 02:05:33 PM
// Design Name: 
// Module Name: InsMem
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


module InsMem(InsMemRW,IAddr,IDataOut);
    
    input InsMemRW;
    input [31:0] IAddr;
    output reg [31:0] IDataOut;
    
    reg [7:0] rom [99:0];
    initial 
    begin
       $readmemb("C:/Users/Sherry/Desktop/rom_data.txt", rom);
    end
    always@(InsMemRW or IAddr)
     
    begin
        $display("alway in IM");
        if(InsMemRW == 0)
        begin
            $display("IF in IM");
            IDataOut[31:24] = rom[IAddr];
            IDataOut[23:16] = rom[IAddr+1];
            IDataOut[15:8] = rom[IAddr+2];
            IDataOut[7:0] = rom[IAddr+3];
            $display(IDataOut);
        end
    end
endmodule