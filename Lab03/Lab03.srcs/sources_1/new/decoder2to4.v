`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 04:43:45 PM
// Design Name: 
// Module Name: decoder2to4
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


module decoder2to4(input [1:0]A, output reg[3:0] Q, input EN);
    always@* begin
    if(EN == 1) begin
        case(A)
        2'b00: Q<=4'b0001;
        2'b01: Q<=4'b0010;
        2'b10: Q<=4'b0100;
        2'b11: Q<=4'b1000;
        endcase
    end else Q <= 4'b0000;
    end
endmodule
