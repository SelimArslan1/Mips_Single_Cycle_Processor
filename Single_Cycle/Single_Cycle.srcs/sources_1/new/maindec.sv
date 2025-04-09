`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 06:47:09 PM
// Design Name: 
// Module Name: maindec
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


module maindec (input logic[5:0] op,
output logic memtoreg, memwrite, branch,
output logic alusrc, regdst, regwrite, jump, jalsub, shamt,
output logic[1:0] aluop );
    logic [10:0] controls;
    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump, jalsub, shamt} = controls; // Assigning to all the output signals with one
   
    always_comb begin
    case (op)
        6'b100011: controls <= 11'b10100100000; // LW
        6'b101011: controls <= 11'b00101000000; // SW
        6'b000100: controls <= 11'b00010001000; // BEQ
        6'b001000: controls <= 11'b10100000000; // ADDI
        6'b000010: controls <= 11'b00000000100; // J
        6'b000000: controls <= 11'b11000010000; // R-Type
        6'b000001: controls <= 11'b11000010010; // jalsub
        6'b000011: controls <= 11'b11000010001; // sra
        default:   controls <= 11'bxxxxxxxxx; // illegal op
    endcase
end
endmodule
