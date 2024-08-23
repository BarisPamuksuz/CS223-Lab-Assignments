`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 06:28:43 PM
// Design Name: 
// Module Name: mux4to1
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


module mux4to1(A, B, C, D, S0, S1, Y);
    input A, B, C, D, S0, S1;
    output Y;
    reg Y, w1, w2;
    always @(A, B, C, D, S0, S1) begin
        if (S0 == 0)w1 = A;
        else w1 = B;
        if (S0 == 0) w2 = C;
        else w2 = D;
        if (S1 == 0) Y = w1;
        else Y = w2;
    end
endmodule
