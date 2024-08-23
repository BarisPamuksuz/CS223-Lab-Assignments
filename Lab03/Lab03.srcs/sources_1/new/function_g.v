`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 05:14:06 PM
// Design Name: 
// Module Name: function_g
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


module function_g(w1,w2,w3,Y);
    input w1,w2,w3;
    output Y;
    reg Y;
    always @(w1,w2,w3) begin
        if(w1==0) Y<= w2&w3;
        else Y<= w2||w3;
    end
endmodule

