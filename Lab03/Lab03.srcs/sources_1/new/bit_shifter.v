`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 07:09:18 PM
// Design Name: 
// Module Name: bit_shifter
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


module bit_shifter(W,shift, Y, k);
    input [3:0]W;
    input shift;
    output [3:0] Y;
    output k;
    reg [3:0]Y; 
    reg k;
    always@(W, shift) begin
       if(shift) begin
            k = W[0];
            Y <= W >> 1;
       end 
       else begin
            k = 0;
            Y <= W;
       end
    end            
endmodule
