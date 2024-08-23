`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 05:18:49 PM
// Design Name: 
// Module Name: function_g_testBench
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
module function_g_testBench();
    reg w1,w2,w3;
    wire Y;
    function_g g(.w1(w1), .w2(w2), .w3(w3), .Y(Y));
    initial begin
        #10 w1 = 0; w2 = 0; w3 = 0;
        #10 w1 = 0; w2 = 0; w3 = 1; 
        #10 w1 = 0; w2 = 1; w3 = 0; 
        #10 w1 = 0; w2 = 1; w3 = 1; 
        #10 w1 = 1; w2 = 0; w3 = 0; 
        #10 w1 = 1; w2 = 0; w3 = 1; 
        #10 w1 = 1; w2 = 1; w3 = 0; 
        #10 w1 = 1; w2 = 1; w3 = 1; 
    end
    initial begin
        $monitor($time, " w1=%b, w2=%b, w3=%b, Y=%b", w1, w2, w3, Y);
    end
endmodule


