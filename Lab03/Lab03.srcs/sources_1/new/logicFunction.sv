`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2024 12:53:50 PM
// Design Name: 
// Module Name: logicFunction
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


module logicFunction(input logic A,B,C,D,E, output logic F);
    
    wire o1,o2,o3,o4;
    wire [1:0] inDec;
    assign inDec[1] = A;
    assign inDec[0] = E;
    wire [3:0] out;
    wire [2:0] selectors;
    assign selectors = {B,C,D};
    wire [7:0] inMux;
    decoder2to4 dec(.A(inDec), .Q(out), .EN(1));
    assign o4 = out[3];
    assign o3 = out[2];
    assign o2 = out[1];
    assign o1 = out[0];
    assign inMux = {o3, o4, ~E, 1'b0, o2, o4, ~o2, ~o1};
    mux8to1 muxy(.A(inMux) ,.S(selectors),.Y(F));
endmodule
