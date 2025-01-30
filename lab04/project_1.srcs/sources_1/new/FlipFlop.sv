`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2024 04:33:19 PM
// Design Name: 
// Module Name: FlipFlop
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


module DFlipFlop(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out        
    );
    logic clk2;
    clkDivider divider(clk,clk2);
    always_ff@(posedge clk2) begin
        if(reset) out <= 1'b0;
        else out <= in;
    end
endmodule
