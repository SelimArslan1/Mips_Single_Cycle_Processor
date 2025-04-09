`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 06:50:00 PM
// Design Name: 
// Module Name: datapath
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


module datapath (input logic clk, reset, memtoreg, pcsrc, alusrc, regdst,
    input logic regwrite, jump, jalsub, shamt,
    input logic[2:0] alucontrol,
    output logic zero,
    output logic[31:0] pc,
    input logic[31:0] instr,
    output logic[31:0] aluout, writedata,
    input logic[31:0] readdata);
    
        logic [4:0] writereg;
        logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
        logic [31:0] signimm, signimmsh, srca, srcb, result;
        
        // next PC logic
        flopr #(32) pcreg(clk, reset, pcnext, pc);
        adder pcadd1(pc, 32'b100, pcplus4);
        sl2 immsh(signimm, signimmsh);
        adder pcadd2(pcplus4, signimmsh, pcbranch);
        mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc,
        pcnextbr);
        
        // Changed !!!!!-----------------
        logic resultTemp;
        mux2 #(32) resultJumpMux({pcplus4[31:28],
        instr[25:0], 2'b00}, result, jalsub, resultTemp);
        // Changed !!!!!-----------------        
        
        mux2 #(32) pcmux(pcnextbr, resultTemp, jump, pcnext);
        
        // Changed !!!!!-----------------
        logic[4:0] writeRegSrc;
        mux2 #(5) wrmux (instr[20:16], instr[15:11], regdst, writeRegSrc);
        mux2 #(5) wrmux2 ( writeRegSrc, 5'd31, jalsub, writeReg);
        // Changed !!!!!-----------------
        
        // register file logic
        regfile rf (clk, regwrite, instr[25:21], instr[20:16], writereg,
        result, srca, writedata);
        
        mux2 #(32) resmux (aluout, readdata, memtoreg, result);
        signext se (instr[15:0], signimm);
        
        // Changed !!!!!-----------------
        logic [31:0] shamtIm;
        assign shamtIm = {27'b0, instr[10:6]};
        // Changed !!!!!-----------------
        
        // ALU logic
        logic [31:0] temp;
        
        mux2 #(32) shamtmux(signimm, shamtIm, shamt, temp);
        mux2 #(32) srcbmux (writedata, temp, alusrc, srcb);
        
        alu alu (srca, srcb, alucontrol, aluout, zero);
endmodule

