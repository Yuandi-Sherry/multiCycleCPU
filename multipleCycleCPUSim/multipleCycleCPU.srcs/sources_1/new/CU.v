`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2018 02:12:36 PM
// Design Name: 
// Module Name: CU
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


module CU(CLK, RST, zero, sign, op, // input
    PCWre, PCSrc, 
    InsMemRW, IRWre, 
    WrRegDSrc, RegDst, RegWre, 
    ALUOp, ALUSrcA, ALUSrcB,
    mRD, mWR, DBDataSrc, ExtSel,state);
input CLK, RST, zero, sign;
input [5:0] op;
output reg PCWre, InsMemRW, IRWre,WrRegDSrc, RegWre,ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc, ExtSel;
output reg [1:0] PCSrc, RegDst;
output reg [2:0] ALUOp;
output reg [2:0] state;

initial begin
    state = 4'b0000; //IF
    PCWre = 1;
    PCSrc = 2'b00;
    InsMemRW = 0; // дIR
    IRWre = 1; // дʹ��
    WrRegDSrc = 1;// д��Ĵ���ALU����������洢����������
    RegDst = 2'b10; // д��rd
    RegWre = 1; // д��Ĵ�����
    ALUOp = 3'b000;
    ALUSrcA = 0; // ѡ��Ĵ�����������
    ALUSrcB = 0; 
    mRD = 0;// �洢���������̬
    mWR = 0; // �޲���
    DBDataSrc = 0; // ���ALU������
    ExtSel = 0; // ����չ
end
//****************** ״̬ת�� *********************
// ʱ�������ػ���RST�½��ش���״̬ת��
always @(posedge CLK or negedge RST) begin 
    if(RST == 0)
    begin
        state <= 3'b000; // IF
    end
    else
    begin
        if(state == 3'b000) // in IF
            state <= 3'b001; // => ID
        else if(state == 3'b001) // in ID
        begin
            // sub, addi, or,
            // and, ori, sll, 
            // slt, sltiu, beq, 
            // bltz, sw, lw => EXE 010           
            if(op == 6'b000001 || op == 6'b000010 || op == 6'b010000
            || op == 6'b010001 || op == 6'b010010 || op == 6'b011000
            || op == 6'b100110 || op == 6'b100111 || op == 6'b110100
            || op == 6'b110110 || op == 6'b110000 || op == 6'b110001) 
                state <= 3'b010;
            // j,jal,jr,halt => IF 000
            else if (op == 6'b111000 || op == 6'b111010
                  || op == 6'b111001 || op == 6'b111111)
                state <= 3'b000;
        end
        
        else if(state == 3'b010) // in EXE
        begin 
            // sub, addi, or,
            // and, ori, sll, 
            // slt, sltiu => WB 011
            if (op == 6'b000001 || op == 6'b000010 || op == 6'b010000
             || op == 6'b010001 || op == 6'b010010 || op == 6'b011000 
             || op == 6'b100110 || op == 6'b100111)
                state <= 3'b011;
            // sw, lw => MEM 100
            else if (op == 6'b110000 ||op == 6'b110001)
                state <= 3'b100;
            // beq, bltz => IF 000
            else if (op == 6'b110100 || op == 6'b110110)
                state <= 3'b000;
        end
        else if (state == 3'b011) // in WB => IF
            state <= 3'b000;
        else if (state == 3'b100) // in MEM => WB
        begin
            // sw => IF
            if(op == 6'b110000)
                state <= 3'b000;
            // lw => WB
            else if(op == 6'b110001)
                state <= 3'b011;
        end
    end
end


//****************** �����źŴ��� *********************
always@(RST or zero or sign or op or state)
begin
    // EXE: ALUSrcA: sll => 1; else: add��sub��addi��or��and��ori��beq��bltz��slt��sltiu��sw��lw => 0; 
    if(state == 3'b010 && op == 6'b011000)
        ALUSrcA = 1;
    else
        ALUSrcA = 0;
        
    // EXE: ALUSrcB:addi��ori��sltiu��lw��sw => 1; else : add��sub��or��and��beq��bltz��slt��sll => 0; 
    if(state == 3'b010 && (op == 6'b000010 ||op == 6'b010010 ||op == 6'b100111 || op == 6'b110001 || op == 6'b110000))
        ALUSrcB = 1;
    else
        ALUSrcB = 0;
        
    // MEM: DBDataSrc:lw => 1; else: add��sub��addi��or��and��ori��slt��sltiu��sll => 0
    if(state == 3'b100 && op == 6'b110001)
        DBDataSrc = 1;
    else
        DBDataSrc = 0;
        
    // WB �׶λ� ID �׶�����õ������ӳ���ָ�� jal => 1
    if(state == 3'b011 || (state == 3'b001 && op == 6'b111010))
        RegWre = 1;
    else
        RegWre = 0;
        
    // ID: WrRegDSrc: jal => 0
    if(state == 3'b001 && op == 6'b111010)
        WrRegDSrc = 0;
    else 
        WrRegDSrc = 1;
    
    // MEM: mRD: lw => 1
    if(state == 3'b100 && op == 6'b110001)  
        mRD = 1;
    else
        mRD = 0;
        
    // MEM: mWR: sw => 1
    if(state == 3'b100 && op == 6'b110000)  
        mWR = 1;
    else
        mWR = 0;
    // IF: IRWre=>1
    if(state == 3'b000)
        IRWre = 1;
    else
        IRWre = 0;
    
    // EXE: ori, slitu: ExtSel => 0
    if(state == 3'b010 && (op == 6'b010010 || op == 6'b100110))
        ExtSel = 0;
    else
        ExtSel = 1;
        
    // ID: j, jal => 11, jr => 10
    if(state == 3'b001)
    begin
        if(op == 6'b111000 || op == 6'b111010)
            PCSrc = 2'b11;
        else if(op == 6'b111001)
            PCSrc = 2'b10;
        else 
            PCSrc = 2'b00;
    end
    // EXE: beq(zero = 1),bltz(sign = 1, zero = 0) 
    if(state == 3'b010)
    begin
        if((op == 6'b110100 && zero == 1)
         ||(op == 6'b110110 && sign == 1 && zero == 0))
            PCSrc = 2'b01;
        else
            PCSrc = 2'b00;
    end
    // MEM: PCSrc:sw => 00
    if(state == 3'b100 && op == 6'b110000)
        PCSrc = 2'b00;
    // WB: PCSrc:
    if(state == 3'b011)
        PCSrc = 2'b00;
    
    // ID: jal => 00
    if(state == 3'b001 && op == 6'b111010)
        RegDst = 2'b00;
    // WB: addi��ori��sltiu��lw => 01, else => 10
    if(state == 3'b011)
    begin
        if(op == 6'b000010 || op == 6'b010010 || op == 6'b100111 || op == 6'b110001)
            RegDst = 2'b01;
        else
            RegDst = 2'b10;
    end 
    
    if(state == 3'b010)
    begin
        if(op == 6'b000001) // sub
            ALUOp=3'b001;
        else if(op == 6'b100111)// sltiu
            ALUOp = 3'b010;
        else if(op == 6'b100110) // slt
            ALUOp = 3'b011;
        else if(op == 6'b011000) // sll
            ALUOp = 3'b100;
        else if((op == 6'b010010)||(op == 6'b010000)) // ori, or
            ALUOp = 3'b101;
        else if(op == 6'b010001) // and
            ALUOp = 3'b110;
        else if((op == 6'b110100)||(op == 6'b110110)) // beq, bltz
            ALUOp = 3'b111;
        else 
            ALUOp = 3'b000;
    end
    else 
        ALUOp=3'b000;
    if(state == 3'b001) begin // ��ID�׶�j, jal, jr��Ҫ��PCWre = 1
        if(op == 6'b111000 || op == 6'b111010 || op == 6'b111001)
            PCWre <= 1;
        else
            PCWre <= 0;
    end
    else if (state == 3'b010) begin // ��EXE�׶Σ�beq,bltzҪ��PCWre = 1
        if(op == 6'b110100 || op == 6'b110110)
            PCWre <= 1;
         else
            PCWre <= 0;
    end
    else if (state == 3'b011)  // ��WB�׶Σ�PCWre = 1
        PCWre = 1;
    else if (state == 3'b100) begin // ��MEM�׶Σ�swҪ��PCWre = 1��
        if(op == 6'b110000)
            PCWre <= 1;
        else PCWre <= 0;   
    end
    else // halt
        PCWre <= 0; 
end

endmodule
