`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2024 12:53:54 PM
// Design Name: 
// Module Name: multidigitCounterTestbench
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


module multidigitCounterTestbench();
    reg[15:0] D = 16'b0;
    reg enable;
    reg load;
    reg clk; 
    reg reset;
    wire[6:0] out = 0;
    wire[3:0] segmentActivate = 0;
    
    BCDcounter7SegmentDisplay dut(out, D, enable, load, clk, reset, segmentActivate);
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end
    initial begin
            
         reset=1;enable=0;load=0;D=16'b1010101010101010;
         #10; load = 1;
         #10; reset = 1; load = 0;    
    end
    
endmodule
