`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 07:35:34 PM
// Design Name: 
// Module Name: testBench_trafficController
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



module testBench_trafficController();
    logic TA, TB, clk = 0, reset;
    logic [1:0] LA, LB;
    
    
    trafficController dut(TA, TB, clk, reset, LA, LB);

    initial begin
        
        reset = 1; TA = 0; TB = 0;
        #40 reset = 0;  
        #150; TA = 1;
        #150; TB = 0;
        #150; TA = 1;
        #150; TB = 1;
        #150; TA = 0; TB = 1;
        #150; TA = 1; TB = 1;
    end

    always #10 clk = ~clk;
endmodule

