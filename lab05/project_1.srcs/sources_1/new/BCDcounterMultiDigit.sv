`timescale 1ns / 1ps

module BCDcounter7SegmentDisplay(
    output logic[6:0] out,
    input logic[15:0] D,
    input logic enable,
    input logic load,
    input logic clk,
    input logic reset
);
    logic[3:0] num1, num2, num3, num4;
    output logic[3:0] segmentActivate;
    logic[6:0] num1_out, num2_out, num3_out, num4_out;
    logic[1:0] signalChange = 2'b00;
    integer count1 = 0;
    logic clk_out;

    MultiDigitDisplay(clk,num1,num2,num3,num4,segmentActivate,out);
    // Counter and load logic
    always @(posedge clk_out) begin
        if (reset) begin
            num1 <= 0; num2 <= 0; num3 <= 0; num4 <= 0;
        end else if (enable) begin 
            if (load) begin
                num4 <= D[15:12];
                num3 <= D[11:8];
                num2 <= D[7:4];
                num1 <= D[3:0];
            end else begin
                num1 <= num1 + 1;
                if (num1 == 4'b1010) begin
                    num1 <= 0;
                    num2 <= num2 + 1;
                    if (num2 == 4'b1010) begin
                        num2 <= 0;
                        num3 <= num3 + 1;
                        if (num3 == 4'b1010) begin
                            num3 <= 0;
                            num4 <= num4 + 1;
                            if (num4 == 4'b1010) begin
                                num4 <= 0;
                                num3 <= 0;
                                num2 <= 0;
                                num1 <= 0;
                            end
                        end
                    end
                end 
            end
        end
    end
   
endmodule
