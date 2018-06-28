`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/19 14:28:19
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input CLK,
    input Reset,
    output CLK190,
    output CLK3
    );
    
reg [25:0] wires;

always @(posedge CLK or negedge Reset)
begin
     if(Reset==0)begin
        wires<=0;
     end
     else begin
        wires<=wires+1;
     end
end

assign CLK190=wires[17];// ¡ã??¨¹???¨¦?¡À??
assign CLK3=wires[25];//?????????¡Â?¡À??

endmodule
