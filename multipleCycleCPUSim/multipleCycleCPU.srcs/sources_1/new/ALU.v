`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 11:11:37 PM
// Design Name: 
// Module Name: ALU
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


module ALU(InA, InB, ALUOp, result, zero, sign);
input [31:0] InA, InB;
input [2:0] ALUOp;
output reg [31:0] result;
output zero, sign;
always @ (ALUOp or InA or InB)
begin
     case (ALUOp)
         3'b000://add
             result = InA+InB;
         3'b001://minus
             result = InA-InB;        
         3'b010:
             result = (InA < InB) ? 1:0;  
         3'b011:// or
         begin
            if(InA < InB && (InA[31] == InB[31]))
                result = 1;
            else if (InA[31] == 1 && InB[31] == 0)
                result = 1;
            else
                result = 0;
            end  
         3'b100:// and
            result = InB << InA;
            
             
         3'b101: // < unsigned
            result =  InA|InB; 
         3'b110: // < signed
            result = InA & InB;
         3'b111: // xor
             result = InA ^ InB;
         default:
         begin
             result = 32'h00000000;
             $display("no match");
         end
     endcase
 end
    
assign zero = (result == 0) ? 1:0;
assign sign = result[31];
endmodule
