`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 06:55:30 PM
// Design Name: 
// Module Name: trafficController
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


module trafficController(input TA,TB,clk,reset,output reg[2:0] LA,output reg[2:0]LB);
    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110, s7 = 3'b111;
    reg[2:0] state, nextState;
    wire clk_out;
    clkDivider divider(clk, clk_out);
    
    
    //state register logic
    always@(posedge clk_out, posedge reset)
        if(reset==1) state <= s0;
        else state <= nextState;
    //combinational circuit
    always@(state, TA,TB)
        case(state)
            s0: if(TA) nextState<=s0;
                else nextState <= s1;
            s1: nextState <= s2;
            s2: nextState <= s3;
            s3: nextState <= s4;
            s4: if(TB) nextState <= s4;
            else nextState <= s5;
            s5: nextState <= s6;
            s6: nextState <= s7;
            s7: nextState <= s0;
        endcase
    //output logic
    always@(state)
        case(state)
            s0: begin LA<=3'b110; LB<=3'b111; end
            s1: begin LA<=3'b100; LB<=3'b111; end
            s2: begin LA<=3'b111; LB<=3'b111; end
            s3: begin LA<=3'b111; LB<=3'b100; end
            s4: begin LA<=3'b111; LB<=3'b110; end
            s5: begin LA<=3'b111; LB<=3'b100; end
            s6: begin LA<= 3'b111; LB<=3'b111; end
            s7: begin LA<= 3'b100; LB<= 3'b111; end
        endcase
endmodule
