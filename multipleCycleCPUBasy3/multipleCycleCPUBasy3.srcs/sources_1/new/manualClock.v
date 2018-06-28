`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/19 14:37:08
// Design Name: 
// Module Name: manualClock
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

module manualClock(CLK,Key,Led);
input CLK;
input Key;
output Led;

reg led=1;

always@(posedge CLK)
begin
  if(Key==0)
    led <=0;
  else
    led <=1;
end

assign Led=led;

endmodule
