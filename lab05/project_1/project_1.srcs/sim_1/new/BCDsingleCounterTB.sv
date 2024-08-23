`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/29/2024 09:15:00 AM
// Design Name:
// Module Name: Testbench_BCDCounter
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
// This testbench is designed to validate the BCDCounter module. It tests normal
// incrementing behavior, rolling over from 9 to 0, direct loading of values, and
// the reset functionality.
//
// Dependencies:
// - BCDCounter
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module Testbench_BCDCounter;
    reg clk;
    reg reset;
    reg enable;
    reg load;
    reg [3:0] d;
    wire [3:0] q;
    BCDCounterSingle2 dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load(load),
        .d(d),
        .q(q)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

    initial begin
        reset = 1; enable = 0; load = 0; d = 4'b0000;
        #10;         
        reset = 0; 
        enable = 1;   
        #150;  
        load = 1;
        d = 4'b0101; 
        #10;  
        load = 0;
        #50;  
        d = 4'b1001;  
        load = 1;
        #10;
        load = 0;
        #20;  
        reset = 1;
        #10; 
        reset = 0;
        #50;     
    end
endmodule
