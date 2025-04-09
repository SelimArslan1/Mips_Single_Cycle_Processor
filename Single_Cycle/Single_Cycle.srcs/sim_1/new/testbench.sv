`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2025 08:15:02 AM
// Design Name: 
// Module Name: testbench
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


`timescale 1ns / 1ps

module testbench;

    // Inputs
    logic clk;
    logic reset;

    // Outputs
    logic [31:0] writedata;
    logic [31:0] dataadr;
    logic [31:0] pc;
    logic [31:0] instr;
    logic [31:0] readdata;
    logic memwrite;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .reset(reset),
        .writedata(writedata),
        .dataadr(dataadr),
        .pc(pc),
        .instr(instr),
        .readdata(readdata),
        .memwrite(memwrite)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        #20; // Hold reset for 20ns

        reset = 0; // Release reset
        #200; // Run for 200ns

        // Monitor the outputs
        $display("Time\tPC\tInstr\tMemWrite\tDataAdr\tWriteData\tReadData");
        $monitor("%0t\t%h\t%h\t%b\t%h\t%h\t%h", $time, pc, instr, memwrite, dataadr, writedata, readdata);

        // Finish simulation
        #100; // Run for an additional 100ns
        $finish;
    end
endmodule
