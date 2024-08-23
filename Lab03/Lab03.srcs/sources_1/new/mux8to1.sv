`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 06:18:37 PM
// Design Name: 
// Module Name: mux8to1
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

module mux8to1(input logic [7:0] A, input logic [2:0] S, output logic Y);
    wire w1,w2;
    logic notS2;
    mux4to1 mux1(.A(A[0]),.B(A[1]),.C(A[2]),.D(A[3]),.S0(S[0]),.S1(S[1]), .Y(w1));
    mux4to1 mux2(.A(A[4]),.B(A[5]),.C(A[6]),.D(A[7]),.S0(S[0]),.S1(S[1]), .Y(w2));
    not notGate(notS2, S[2]);
    assign Y = (w1 & notS2) | (w2 & S[2]);
endmodule

