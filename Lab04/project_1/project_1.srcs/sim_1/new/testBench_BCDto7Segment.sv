`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2024 11:44:50 AM
// Design Name: 
// Module Name: testBench_BCDto7Segment
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


module testBench_BCDto7Segment();
    logic[3:0] w;
    logic[6:0] outPut;
    
    BCDto7Segment dut(w,outPut);
    initial begin
        w = 4'b0000;
        #10; 
        for(int i = 0; i < 16; i++) begin
            w = i;
            #10;
        end
        $finish;
    end
    
endmodule
