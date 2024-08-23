`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2024 01:47:24 PM
// Design Name: 
// Module Name: logicFunction_testBench
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


module logicFunction_testBench();
    reg A,B,C,D,E;
    wire F;
    
    logicFunction func(.A(A),.B(B),.C(C),.D(D),.E(E),.F(F));
    initial begin
        #100
        #10 A = 0; B = 0; C = 0; D = 0; E = 0;
        #10;A = 0; B = 0; C = 0; D = 0; E = 1;
        #10;A = 0; B = 0; C = 0; D = 1; E = 0;
        #10;A = 0; B = 0; C = 0; D = 1; E = 1;
        #10;A = 0; B = 0; C = 1; D = 0; E = 0;
        #10;A = 0; B = 0; C = 1; D = 0; E = 1;
        #10;A = 0; B = 0; C = 1; D = 1; E = 0;
        #10;A = 0; B = 0; C = 1; D = 1; E = 1;
        #10;A = 0; B = 1; C = 0; D = 0; E = 0;
        #10;A = 0; B = 1; C = 0; D = 0; E = 1;
        #10;A = 0; B = 1; C = 0; D = 1; E = 0;
        #10;A = 0; B = 1; C = 0; D = 1; E = 1;
        #10;A = 0; B = 1; C = 1; D = 0; E = 0;
        #10;A = 0; B = 1; C = 1; D = 0; E = 1;
        #10;A = 0; B = 1; C = 1; D = 1; E = 0;
        #10;A = 0; B = 1; C = 1; D = 1; E = 1;
        #10;A = 1; B = 0; C = 0; D = 0; E = 0;
        #10;A = 1; B = 0; C = 0; D = 0; E = 1;
        #10;A = 1; B = 0; C = 0; D = 1; E = 0;
        #10;A = 1; B = 0; C = 0; D = 1; E = 1;
        #10;A = 1; B = 0; C = 1; D = 0; E = 0;
        #10;A = 1; B = 0; C = 1; D = 0; E = 1;
        #10;A = 1; B = 0; C = 1; D = 1; E = 0;
        #10;A = 1; B = 0; C = 1; D = 1; E = 1;
        #10;A = 1; B = 1; C = 0; D = 0; E = 0;
        #10;A = 1; B = 1; C = 0; D = 0; E = 1;
        #10;A = 1; B = 1; C = 0; D = 1; E = 0;
        #10;A = 1; B = 1; C = 0; D = 1; E = 1;
        #10;A = 1; B = 1; C = 1; D = 0; E = 0;
        #10;A = 1; B = 1; C = 1; D = 0; E = 1;
        #10;A = 1; B = 1; C = 1; D = 1; E = 0;
        #10;A = 1; B = 1; C = 1; D = 1; E = 1;
        #10;
        
    end    
endmodule
