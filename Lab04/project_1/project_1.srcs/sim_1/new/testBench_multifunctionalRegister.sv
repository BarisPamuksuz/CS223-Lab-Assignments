`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2024 08:28:03 PM
// Design Name: 
// Module Name: testBench_multifunctionalRegister
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


module testBench_multifunctionalRegister();
    logic shift_in = 0;
    logic[1:0] s = 2'b00;
    logic reset = 0;
    logic clk = 0;
    logic[3:0] D = 4'b000;
    logic[3:0] Q = 4'b000;
    
    multifunctionRegister dut(shift_in, s, reset, clk, D, Q);
    initial begin
        
        #10; D = 4'b1011;
        #10; shift_in = 1;
        #10; reset = 1; s[1]=0; s[0]=0;// Reset is expected, outputs(Q[3:0]) will be checked.Q = 0000
        #10; reset = 0; s[1]=0; s[0]=0;// Maintaining present value is expected. Q = 0000 
        #10; reset = 0; s[1]=0; s[0]=1;// Parallel load(1011) is expected Q = 1011
        #10; reset = 0; s[1]=1; s[0]=0;// shift left is expected Q = 0111
        #10; // One cycle more LEFT shifting Q = 1111
        #10; reset = 0; s[1]=1; s[0]=1;// shift right is expected Q = 1011
        
        #40;//Keep shifting RIGHT for 4 clock cycles
        
        #10; D = 4'b0101;
        #10; shift_in = 0;
        
        #10; reset = 1; s[1]=0; s[0]=0;// Reset is expected, outputs(Q[3:0]) will be checked. Q = 0000
        #10; reset = 0; s[1]=0; s[0]=0;// Maintaining present value is expected Q = 0000
        #10; reset = 0; s[1]=0; s[0]=1;// Parallel load(0101) is expected Q = 0101
        #10; reset = 0; s[1]=1; s[0]=0;// shift left is expected Q = 1010
        #10; reset = 0; s[1]=1; s[0]=1;// shift right is expected Q = 0101
        #20; $finish;
        
    end

    
    always  
        begin
         clk = 0; #5; clk = 1; #5;
    end
        
endmodule
