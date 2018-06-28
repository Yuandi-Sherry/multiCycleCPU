`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/19 14:39:26
// Design Name: 
// Module Name: SelectDisplay
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

module SelectDisplay(
    input CLK,
    input Reset,
    input [1:0] Selector,
    input [7:0] PC,NextPC,
    input [4:0] Rs,Rt,
    input [7:0] ReadData1,ReadData2,Result,DataOut,
    output [15:0] Out
);

reg [15:0] out;
// ??????
initial begin
    out<=0;
end
// ??????????¡Á¨¦????
always @(*) 
begin
    case(Selector)
        // ?¡À?¡ãPC????????????PC??
        2'b00:begin
            out[15:8]=PC[7:0];
            out[7:0]=NextPC[7:0];
        end
        // RS?????¡Â???¡¤??RS?????¡Â????
        2'b01:begin
            out[15:13]=0;
            out[12:8]=Rs;
            out[7:0]=ReadData1[7:0];
        end
        // RT?????¡Â???¡¤??RT?????¡Â????
        2'b10:begin
            out[15:13]=0;
            out[12:8]=Rt;
            out[7:0]=ReadData2[7:0];
        end
        // ALU?¨¢????????DB¡Á???????
        2'b11:begin
            out[15:8]=Result[7:0];
            out[7:0]=DataOut[7:0];
        end
     endcase     
end

assign Out=out;

endmodule

