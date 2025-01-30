`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 03:21:23 AM
// Design Name: 
// Module Name: testBench_rx_part2
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


module testBench_rx_part2(
    );
    reg clock = 1'b0;
    reg[7:0] data_to_transfer = 8'b0;
    reg loadButton = 1'b0;
    reg data_ready_button = 1'b0;
    reg[7:0] display_discarded_transfer = 8'b0;
    reg currentBit_toSend =1'b0;
    reg[7:0] memory[3:0];
    
    Uart_tx dut(data_to_transfer, data_ready_button, loadButton, clock, currentBit_toSend, display_discarded_transfer,memory);
    always #10 clock = ~clock;
    initial begin
        loadButton = 0; data_ready_button <= 0;
        data_to_transfer<=8'b1;#10; loadButton <= 1; #10; loadButton <= 0;
        #10; data_to_transfer <= 8'b00000011;#10; loadButton<=1;#10; loadButton <= 0;
        #10; data_to_transfer <= 8'b00000111;#10; loadButton<=1;#10; loadButton<= 0;
    end    
     
endmodule
