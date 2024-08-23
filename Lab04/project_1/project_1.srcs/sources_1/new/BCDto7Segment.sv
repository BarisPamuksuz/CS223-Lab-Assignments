`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2024 11:31:54 AM
// Design Name: 
// Module Name: BCDto7Segment
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


module BCDto7Segment(
    input logic[3:0] w,
    output logic[6:0] outPut
    );
    
    always@(w) begin
        case(w)
            4'b0000: outPut = 7'b0000001;
            4'b0001: outPut = 7'b1001111;
            4'b0010: outPut = 7'b0010010;
            4'b0011: outPut = 7'b0000110;
            4'b0100: outPut = 7'b1001100;
            4'b0101: outPut = 7'b0100100;
            4'b0110: outPut = 7'b0100000;
            4'b0111: outPut = 7'b0001111;
            4'b1000: outPut = 7'b0000000;
            4'b1001: outPut = 7'b0000100;
            4'b1010: outPut = 7'b0000001;
            4'b1011: outPut = 7'b0000001;
            4'b1100: outPut = 7'b0000001;
            4'b1101: outPut = 7'b0000001;
            4'b1110: outPut = 7'b0000001;
            4'b1111: outPut = 7'b0000001;
        endcase    
    end
    
endmodule
