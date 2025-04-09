`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 06:46:05 PM
// Design Name: 
// Module Name: controller
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


module controller(input logic[5:0] op, funct,
input logic zero,
output logic memtoreg, memwrite,
output logic pcsrc, alusrc,
output logic regdst, regwrite,
output logic jump,
output logic jalsub,
output logic shamt,
output logic[2:0] alucontrol);

    logic [1:0] aluop;
    logic branch;
    
    maindec md (op, memtoreg, memwrite, branch, alusrc, regdst, regwrite,
    jump, jalsub, shamt, aluop); // Decoder for the multiplexer signals per instruction
    aludec ad (funct, aluop, alucontrol); // Decoder for the ALU signals per instruction
    assign pcsrc = branch & zero; // Signal for the PC's branch multiplexer
    
endmodule
