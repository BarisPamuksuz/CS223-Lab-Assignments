`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 04:47:01 PM
// Design Name: 
// Module Name: decoder2to4_testbench
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


module decoder2to4_testbench;
    reg [1:0] A;
    reg EN;
    wire [3:0] Q;
    decoder2to4 uut(.A(A), .Q(Q), .EN(EN));
    initial begin
        EN =1;
        A = 2'b00;
        #10 A = 2'b01;
        #10 A = 2'b10;
        #10 A = 2'b11;
    end
    initial begin
        $monitor($time, " A=%b, Q=%b", A, Q);
    end
endmodule
