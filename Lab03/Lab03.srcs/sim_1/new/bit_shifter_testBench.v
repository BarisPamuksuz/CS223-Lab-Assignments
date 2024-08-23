`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 07:21:42 PM
// Design Name: 
// Module Name: bit_shifter_testBench
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


module bit_shifter_testBench();
    reg [3:0] W;
    reg shift;
    wire [3:0] Y;
    wire k;

    bit_shifter shifter(.W(W), .shift(shift), .Y(Y), .k(k));
       integer sum;
    initial begin
        W = 4'b0000;
        shift = 1; 
        $monitor($time, " W=%b, Y=%b, shift=%b, k=%b", W, Y, shift, k);
        for (sum = 1; sum <= 15; sum = sum + 1) begin
            #5 W = W + 1;
        end
    end
endmodule

