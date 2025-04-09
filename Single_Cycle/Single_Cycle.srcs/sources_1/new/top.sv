//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 06:40:51 PM
// Design Name: 
// Module Name: top
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


module top  (input   logic   clk, clk_button, reset_button, clear,
    output logic[6:0] seg,
    output logic[3:0] an,
    output logic dp,
    output  logic   memwrite_led);     
    
    logic[31:0] writedata, dataadr, pc, instr, readdata;
    logic memwrite;
    logic clk_pulse, reset_pulse;
    
    assign memwrite_led = memwrite;
    
    pulse_controller clkpls(clk, clk_button, clear, clk_pulse);
    pulse_controller rstpls(clk, reset_button, clear, reset_pulse);
    
    
    display_controller(clk, pc[7:4], pc[3:0], dataadr[7:4], dataadr[3:0], 
        seg, dp, an);
    
    // instantiate processor and memories   
    mips mips (clk_pulse, reset_pulse, pc, instr, memwrite, dataadr, writedata, readdata);   
    imem imem (pc[7:0], instr);   
    dmem dmem (clk_pulse, memwrite, dataadr, writedata, readdata); 
    
endmodule
