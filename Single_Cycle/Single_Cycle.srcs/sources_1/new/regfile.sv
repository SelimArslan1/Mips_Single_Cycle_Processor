`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 06:51:20 PM
// Design Name: 
// Module Name: regfile
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


module regfile (input logic clk, we3,
input logic[4:0] ra1, ra2, wa3,
input logic[31:0] wd3,
output logic[31:0] rd1, rd2);
    logic [31:0] rf [31:0];
    // three ported register file: read two ports combinationally
    // write third port on rising edge of clock. Register0 hardwired to 0.
    always_ff@(posedge clk)
        if (we3)
        rf [wa3] <= wd3;
        assign rd1 = (ra1 != 0) ? rf [ra1] : 0;
        assign rd2 = (ra2 != 0) ? rf[ ra2] : 0;
endmodule
