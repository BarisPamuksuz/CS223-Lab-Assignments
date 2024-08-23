`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 09:00:00 AM
// Design Name: 
// Module Name: BCDCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// This module implements a BCD counter that increments every second and rolls over
// from 9 to 0. It also supports loading a value directly when enabled.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BCDcounterSingle2(
    input logic clk,          
    input logic reset,        
    input logic enable,   
    input logic load,         
    input logic[3:0] d,       
    output logic[3:0] q       
    );
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;  
        end else if (enable) begin
            if (load) begin
                q <= d; 
            end else begin
                if (q == 4'b1001) begin
                    q <= 4'b0000; 
                end else begin
                    q <= q + 1;
                end
            end
        end
    end
endmodule

