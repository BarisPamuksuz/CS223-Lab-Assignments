`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2024 07:45:35 PM
// Design Name: 
// Module Name: multifunctionRegister
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


module multifunctionRegister(
    input logic shift_in,
    input logic[1:0] s,
    input logic reset,
    input logic clk,
    input logic[3:0] D,
    output logic[3:0] Q
    );
    
    logic flipFlopInput1;
    logic flipFlopInput2;
    logic flipFlopInput3;
    logic flipFlopInput4;
    
    mux4to1 mux1(Q[3], D[3], Q[2], shift_in, s[0], s[1], flipFlopInput1);
    mux4to1 mux2(Q[2], D[2], Q[1], Q[3], s[0], s[1], flipFlopInput2);
    mux4to1 mux3(Q[1], D[1], Q[0], Q[2], s[0], s[1], flipFlopInput3);
    mux4to1 mux4(Q[0], D[0], shift_in, Q[1], s[0], s[1], flipFlopInput4);
    
    DFlipFlop ff1(clk, reset, flipFlopInput1, Q[3]);
    DFlipFlop ff2(clk, reset, flipFlopInput2, Q[2]);
    DFlipFlop ff3(clk, reset, flipFlopInput3, Q[1]);
    DFlipFlop ff4(clk, reset, flipFlopInput4, Q[0]);
    
endmodule
