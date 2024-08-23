`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 08:40:25 PM
// Design Name: 
// Module Name: MultiDigitDisplay
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


module MultiDigitDisplay(
    input logic clk,
    input logic[3:0] num1,
    input logic[3:0] num2,
    input logic[3:0] num3,
    input logic[3:0] num4,
    output logic[3:0] segmentActivate,
    output logic[6:0] out
    );
    
    logic[6:0] num1_out;
    logic[6:0] num2_out;
    logic[6:0] num3_out;
    logic[6:0] num4_out;
    
    logic[1:0] signalChange = 2'b00;
    
    
    BCDto7Segment first(num1, num1_out);
    BCDto7Segment second(num2, num2_out);
    BCDto7Segment third(num3, num3_out);
    BCDto7Segment fourth(num4, num4_out);
    
    integer count = 0;
    logic clk2;
    
    always@(posedge clk) begin
        if(count > 300000)begin
            clk2 = ~clk2;
            count = 1;
        end
        count = count + 1;
    end 
    
    always@(posedge clk2) begin
        signalChange <= signalChange + 1;
        if(signalChange == 2'b11)
            signalChange <= 2'b00;
    end
    
    always@ (*) begin
        case(signalChange) 
            2'b00: begin
                out <= num1_out;
                segmentActivate <= 4'b1110;
            end
            2'b01: begin
                out <= num2_out;
                segmentActivate <= 4'b1101;
            end
            2'b10: begin
                out <= num3_out;
                segmentActivate <= 4'b1011;
            end
            2'b11: begin
                out <= num4_out;
                segmentActivate <= 4'b0111;
            end
        endcase 
    end
                 
endmodule
