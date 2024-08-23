`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 06:19:43 PM
// Design Name: 
// Module Name: mux8to1_testbench
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
module mux8to1_testbench();
 reg [7:0] A;
 reg [2:0] S;
 wire Y;
 mux8to1 mux(.A(A[7:0]), .S(S[2:0]), .Y(Y));
 integer i,j;
 initial begin
    A = 8'b00000000;
    S = 3'b000;
    for (i = 0; i < 8; i = i+1) begin
        A = 8'b00000001 << i;
        for (j = 0; j < 8; j=j+1) begin
            #10 S = j;
        end
    end
 end
 initial begin
    $monitor($time, " A=%b, S=%b, Y=%b", A, S, Y);
 end
endmodule
