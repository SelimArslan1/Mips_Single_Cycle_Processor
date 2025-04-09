`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 06:49:10 PM
// Design Name: 
// Module Name: aludec
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


module aludec (input logic[5:0] funct,
input logic[1:0] aluop,
output logic[2:0] alucontrol);
    always_comb
    // aludec uses funct and aluop to decide on the output bits
    // aluop encoding can be seen in the table 7.1
    // aludec truth table can be seen in the table 7.2
    case(aluop)
        2'b00: alucontrol = 3'b010; // add (for lw/sw/addi)
        2'b01: alucontrol = 3'b110; // sub (for beq)
        default: case(funct) // R-TYPE instructions
            6'b100000: alucontrol = 3'b010; // ADD
            6'b100010: alucontrol = 3'b110; // SUB -> jalsub
            6'b100100: alucontrol = 3'b000; // AND
            6'b100101: alucontrol = 3'b001; // OR
            6'b101010: alucontrol = 3'b111; // SLT
            6'b000001: alucontrol = 3'b011; // SRA
        default: alucontrol = 3'bxxx; // ???
        endcase
    endcase
endmodule
